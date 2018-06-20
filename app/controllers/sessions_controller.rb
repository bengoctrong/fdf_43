class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    log_in @user
    params[:session][:remember_me] == Settings.remember_me ? remember(@user) : forget(@user)
    redirect_to root_path
  end

  def destroy
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
end
