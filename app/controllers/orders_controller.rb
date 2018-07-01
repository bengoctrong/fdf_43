class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, only: :show
  before_action :correct_user, except: %i(index new create)

  def new
    @order = current_user.orders.build
    session[:cart].keys.each do |product_id|
      build_order_product product_id if load_product(product_id)
    end
  end

  def create
    @order = current_user.orders.build order_params
    if @order.save
      clear_cart
      flash[:success] = t ".success"
      redirect_to @order
    else
      flash[:danger] = t ".danger"
      redirect_to root_path
    end
  end

  def show; end

  private

  def build_order_product product_id
    total = @product.price * session[:cart][product_id]
    @order.order_products.build product_id: product_id,
      quantity: session[:cart][product_id], total: total
  end

  def order_params
    params.require(:order).permit :address_ship, :note,
      order_products_attributes: %i(product_id quantity total)
  end

  def load_product product_id
    @product = Product.find_by id: product_id
  end

  def correct_user
    redirect_to root_path unless current_user?(@order.user) || current_user.admin?
  end
end
