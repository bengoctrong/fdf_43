class OrderProductsController < ApplicationController
  before_action :logged_in_user, only: :create

  def create
    @order = current_cart
    @order_product = @order.order_products.new order_product_params
    if @order.save
      flash[:success] = t ".add_product_success"
      session[:order_id] = @order.id
    else
      flash[:danger] = t ".add_product_fail"
      render :new
    end
  end

  private

  def order_products_params
    params.require(:order_product).permit :product_id, :quantity
  end
end
