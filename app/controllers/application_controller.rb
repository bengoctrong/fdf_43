class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "login"
    redirect_to login_path
  end

  def login_as_admin
    return if current_user.admin?
    flash[:danger] = t "login_admin"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit :name, :description, :price, :quantity,
      :product_type, :category_id, images: []
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product && @product.exist?
    flash[:danger] = t "products.product_not_found"
    redirect_to root_path
  end

  def load_user
    @user = User.load_user.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.user_not_found"
    redirect_to root_path
  end
end
