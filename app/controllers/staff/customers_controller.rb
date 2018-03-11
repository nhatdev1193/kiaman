class Staff::CustomersController < Staff::BaseController
  before_action :set_customer, only: [:edit, :update]
  before_action :set_step_and_dynamic_form, only: [:edit, :update]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    ActiveRecord::Base.transaction do
      @customer = Customer.new(customer_params)

      if @customer.save!
        redirect_to staff_customers_path, notice: 'Prospect was successfully created.' if customer_step(@customer, customer_params[:product_id])
      else
        render :new
      end
    end
  rescue => _exception
    render :new
  end

  def create_multi
    ActiveRecord::Base.transaction do
      customers_params[:customers].each do |cus_params|
        next if invalid_customer?(cus_params[:customer])

        cus_params[:customer][:product_id] = customers_params[:product_id]
        @customer = Customer.new(cus_params[:customer])

        if @customer.save!
          customer_step(@customer, customers_params[:product_id])
        else
          render :new
        end
      end
      redirect_to staff_customers_path
    end
  rescue => _exception
    render :new
  end

  def update
    @customer = @customer.update_fields(customer_params, form_fields_params)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_step_and_dynamic_form
    @current_step = @customer.current_step
    @dynamic_form = Form.includes(form_fields: :form_input).find(@current_step.form_id)
  end

  def customer_params
    params[:customer].delete(:merchandise) if params[:customer][:product_id] == '1'
    params[:customer].delete(:school) if params[:customer][:product_id] == '2'
    params.require(:customer).permit(:product_id, :last_name, :first_name, :gender, :phone, :birthday, :school, :merchandise, :nic_number)
  end

  def customers_params
    params[:customers][:customers].each { |c| c[:customer].delete(:merchandise) } if params[:customers][:product_id] == '1'
    params[:customers][:customers].each { |c| c[:customer].delete(:school) } if params[:customers][:product_id] == '2'
    params.require(:customers).permit(
      :product_id,
      customers: [
        customer: [
          :last_name, :first_name, :gender, :phone, :birthday, :school, :merchandise
        ]
      ]
    )
  end

  def form_fields_params
    params.require(:custom_fields).permit(@dynamic_form.form_fields.map { |field| field.id.to_s })
  end

  # Store 1st step of flow into customers_steps
  # Move next step if customer info & 1st step stored successful
  def customer_step(customer, product_id)
    product = Product.find product_id
    customers_step = customer.customers_steps.build(step: product.first_step, created_staff_id: current_staff.id,
                                                    assigned_staff_id: current_staff.id, assigned_at: Time.now)

    return false unless customers_step.save

    customers_step.next_step!(current_staff.id)
  end

  def invalid_customer?(customer)
    customer[:last_name].blank? && customer[:first_name].blank? && customer[:phone].blank? && customer[:gender].blank? && customer[:birthday].blank?
  end
end
