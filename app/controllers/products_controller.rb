class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.paginate(page: params[:page],
      per_page: Settings.per_page_value).order("created_at desc")
  end

  def show; end
end
