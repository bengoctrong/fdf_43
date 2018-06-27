class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    check_login_user
  end

  def destroy
    roll_back_inventory
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user && @user.authenticate(params[:session][:password])
    flash.now[:danger] = t ".danger"
    render :new
  end

  def check_login_user
    if @user.activated?
      log_in @user
      params[:session][:remember_me] == Settings.check_box ? remember(@user) : forget(@user)
      redirect_back_or root_path
    else
      flash[:warning] = t ".warning_msg"
      redirect_to root_path
    end
  end

  def roll_back_inventory
    return if session[:cart].blank?
    @products_of_current_cart = Product.load_product_by_ids session[:cart].keys
    @products_of_current_cart.each do |item|
      item.change_in_cart session[:cart][item.id.to_s]
    end
  end
end
