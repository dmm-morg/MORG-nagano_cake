class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :tax_included_price, :count, :making_status)
  end
end
