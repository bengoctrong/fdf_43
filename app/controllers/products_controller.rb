class ProductsController < ApplicationController
  before_action :load_product, only: :show
  before_action :load_filter, only: :index

  def index
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def show; end

  private

  def filtering_params params
    params.slice(:search_by_name, :types, :category_id, :order_by)
  end

  def load_filter
    @categories = Category.all
    @products = Product.actived.paginate(page: params[:page],
      per_page: Settings.per_page_value)
  end
end
