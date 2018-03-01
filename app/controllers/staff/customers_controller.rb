class Staff::CustomersController < Staff::BaseController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    begin
      Customer.transaction do
        if @customer.save
          customer_step(@customer, customer_params[:product_id])
        else
          render :new
        end
      end
    rescue => _exception
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:product_id, :last_name, :first_name, :gender, :phone, :birthday)
  end

  def customer_step(customer, product_id)
    product = Product.find product_id
    customers_step = customer.customers_steps.build(step: product.first_step, created_staff_id: current_staff.id,
                                                    assigned_staff_id: current_staff.id, assigned_at: Time.now)
    return false unless customers_step.save

    customers_step.next_step!(current_staff.id)
    redirect_to staff_customers_path, notice: 'Prospect was successfully created.'
  end
end
