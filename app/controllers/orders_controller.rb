class OrdersController < ApplicationController
  def index
    @orders = Order.paginate(page: params[:page],
      per_page: Settings.per_page_value).order("created_at desc")
  end

  def show; end
end
