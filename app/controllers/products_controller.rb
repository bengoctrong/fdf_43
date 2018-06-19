class ProductsController < ApplicationController
  before_action :load_product, except: %i(new create)

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "products.create_success"
      redirect_to @product
    else
      render :new
    end
  end

  def show; end

  private

  def product_params
    params.require(:product).permit :name, :description, :price, :quantity,
      :product_type, :category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.product_not_found"
    redirect_to root_path
  end
end
