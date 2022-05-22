class Admin::OrderDetailsController < ApplicationController

    # binding.pry
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(making_status: params[:order_detail][:making_status])
    if params[:order_detail][:making_status] == "manufacturing"
      @order_detail.order.update(order_status: "making")
    elsif params[:order_detail][:making_status] == "finish"
      @order_detail.order.update(order_status: "preparing")
    end

    redirect_to request.referer
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

