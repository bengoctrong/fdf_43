class OrdersController < ApplicationController
  def index
    @orders = Order.paginate(page: params[:page],
      per_page: Settings.per_page_value).order("created_at desc")
  end

  def show; end

  private

  def order_params
    params.require(:order).permit :address_ship, :note,
      order_products_attributes: [:product_id, :quantity, :total]
  end

  def load_product product_id
    @product = Product.find_by id: product_id
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:warning] = "Order not found"
    redirect_to root_path
  end
end
