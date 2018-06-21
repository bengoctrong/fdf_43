module Admin
  class ProductsController < ApplicationController
    before_action :load_product, except: %i(new create)
    before_action :logged_in_user, :login_as_admin, only: %i(new create delete)

    def new
      @product = Product.new
    end

    def create
      @product = Product.new product_params
      if @product.save
        flash[:success] = t ".create.success"
        redirect_to @product
      else
        render :new
      end
    end

    def destroy
      status = @product.deleted! ? :success : :warning
      flash[status] = t ".#{status}"
      redirect_to root_path
    end
  end
end
