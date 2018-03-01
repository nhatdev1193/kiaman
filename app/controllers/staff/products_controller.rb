class Staff::ProductsController < Staff::BaseController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.with_deleted
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to staff_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to staff_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    msg = if @product.deleted? && @product.restore
            'Product was successfully restored.'
          elsif @product.destroy
            'Product was successfully deleted.'
          end
    redirect_to staff_products_path, notice: msg
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end

  def set_product
    @product = Product.with_deleted.find params[:id]
  end
end
