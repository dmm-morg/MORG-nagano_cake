class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new
    @address = Address.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_number] == "3"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      redirect_to request.referer
    end
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800
    @total = @cart_items.inject(0) { |sum, item| + sum + item.subtotal }
    @order.total_payment = @order.shipping_cost + @total
  end



  #   @address = Address.find(params[:order][:address_id])
  #   @order.post_code = @address.post_code
  #   @order.address = @address.address
  #   @order.name = @address.name
  # end

  def create
  end

  def finish
  end

  def index
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost)
    end

    # def address_params
    #   params.require(:order).permit(:name, :address, :post_code)
    # end

    def address_params
      params.require(:order).permit(:name, :address, :name)
    end
end
