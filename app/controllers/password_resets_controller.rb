class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("password_resets.sent_email_msg")
      redirect_to root_url
    else
      flash.now[:danger] = t("password_resets.error_msg")
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".empty_msg")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t(".success_msg")
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email].downcase
    return unless @user.nil?
    flash[:danger] = t("password_resets.user_not_found_msg")
    redirect_to root_url
  end

  # Confirms a valid user.
  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t("password_resets.password_reset_expired")
    redirect_to new_password_reset_url
  end
end
