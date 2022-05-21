class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to request.referer
  end

  private
  def order_params
    params.require(:order).permit(:order_status, :payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_payment)
  end
end
