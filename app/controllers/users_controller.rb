class UsersController < ApplicationController
  before_action :load_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users.activate_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.user_update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :address, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.user_not_found"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
