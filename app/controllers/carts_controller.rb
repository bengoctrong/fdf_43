class CartsController < ApplicationController
  before_action :logged_in_user, only: %i(create index)

  def create
    session[:cart] ||= {}
    @product = Product.find_by id: params[:product_id]
    if session[:cart].key?(@product.id.to_s)
      session[:cart][@product.id.to_s] += 1
    else
      session[:cart][@product.id.to_s] = 1
    end
    redirect_to carts_path
  end

  def index
    unless session[:cart].blank?
      @products_of_current_cart = Product.load_product_by_ids session[:cart].keys
      @products_of_current_cart.each do |item|
        item.quantity_in_cart = session[:cart][item.id.to_s]
      end
    else
      flash[:danger] = t "carts.empty_cart"
      redirect_to products_path
    end
  end
end
