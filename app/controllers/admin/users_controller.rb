module Admin
  class UsersController < ApplicationController
    before_action :load_user, only: :destroy
    before_action :logged_in_user, :login_as_admin

    def destroy
      status = @user.deleted! ? :success : :warning
      flash[status] = t ".destroy.#{status}"
      redirect_to root_path
    end
  end
end
