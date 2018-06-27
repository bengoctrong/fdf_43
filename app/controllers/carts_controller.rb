class CartsController < ApplicationController
  before_action :logged_in_user, except: %i(new show edit)
  before_action :load_product, only: %i(create update destroy)
  before_action :load_product_in_cart, only: :index

  def create
    session[:cart] ||= {}
    session[:cart_count] ||= Settings.cart_value
    if params[:quantity].present?
      add_product params[:quantity].to_i
    else
      add_product Settings.increase_quantity
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    @total = Settings.total
    @products_of_current_cart.each do |item|
      @total += item.total_price_in_cart
    end
  end

  def update
    if session[:cart].key?(@product.id.to_s)
      update_cart
    else
      flash[:danger] = t "carts.update.update_fail"
    end
    redirect_to carts_path
  end

  def destroy
    if session[:cart].key?(@product.id.to_s)
      session[:cart_count] -= session[:cart][@product.id.to_s]
      destroy_cart
    else
      flash[:danger] = t "carts.destroy.destroy_fail"
    end
    redirect_to carts_path
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "carts.product_not_found"
    redirect_to products_path
  end

  def load_product_in_cart
    if session[:cart].blank?
      flash[:danger] = t "carts.empty_cart"
      redirect_to products_path
    else
      calculate_quantity_total
    end
  end

  def add_product quantity
    if @product.change_in_cart(-quantity)
      check_current_product quantity
    else
      flash[:danger] = t "carts.not_enough_product"
      redirect_to root_path
    end
  end

  def check_current_product current_quantity
    session[:cart][@product.id.to_s] ||= Settings.zero_value
    session[:cart][@product.id.to_s] += current_quantity
    session[:cart_count] += current_quantity
  end

  def update_cart
    if @product.change_in_cart session[:cart][@product.id.to_s] - params[:quantity].to_i
      check_update_cart
      flash[:success] = t "carts.update.update_success"
    else
      flash[:danger] = t "carts.not_enough_product"
    end
  end

  def check_update_cart
    session[:cart_count] += params[:quantity].to_i - session[:cart][@product.id.to_s]
    session[:cart][@product.id.to_s] = params[:quantity].to_i
  end

  def destroy_cart
    @product.change_in_cart session[:cart][@product.id.to_s]
    session[:cart].delete @product.id.to_s
    flash[:success] = t "carts.destroy.destroy_success"
  end

  def calculate_quantity_total
    @products_of_current_cart = Product.load_product_by_ids session[:cart].keys
    @products_of_current_cart.each do |item|
      item.quantity_in_cart = session[:cart][item.id.to_s]
      item.total_price_in_cart = item.quantity_in_cart * item.price
    end
  end
end
