class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
    @customer = Customer.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_status: params[:order][:order_status])
    if params[:order][:order_status] == "confirm_payment"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: "waiting_manufacture")
      end
    end
    redirect_to request.referer
  end

  private
  def order_params
    params.require(:order).permit(:order_status, :payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_payment)
  end
end
