class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.actived.paginate(page: params[:page],
      per_page: Settings.per_page_value).newest_product
    @products = @products.search_by_name(params[:search]) if params[:search].present?
    @products = @products.search_by_category(params[:category_id]) if params[:category_id].present?
  end

  def show; end
end
