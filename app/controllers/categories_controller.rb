class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t "users.activate_email"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end
end
