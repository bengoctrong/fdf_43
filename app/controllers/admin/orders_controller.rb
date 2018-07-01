module Admin
  class OrdersController < ApplicationController
    before_action :load_order, except: :index
    before_action :logged_in_user, :login_as_admin

    def index
      @orders = Order.newest.paginate(page: params[:page],
        per_page: Settings.per_page_value)
      @orders = @orders.search_by_status params[:status] if params[:status].present?
    end

    def update
      accept_order if params[:status] == Settings.order.status.accepted
      reject_order if params[:status] == Settings.order.status.rejected
      respond_to do |format|
        format.html{}
        format.js{}
      end
    end

    private

    def accept_order
      @order.accepted! unless @order.accepted?
    end

    def reject_order
      @order.rejected! unless @order.rejected?
    end
  end
end
