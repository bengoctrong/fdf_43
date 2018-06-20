class ProductsController < ApplicationController
  before_action :load_product, only: %i(show index)

  def index; end

  def show; end
end
