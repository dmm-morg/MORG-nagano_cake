class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
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


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    unless Address.where(post_code: @order.post_code)
    address = Address.new
    address.customer_id = current_customer.id
    address.name = @order.name
    address.post_code = @order.post_code
    address.address = @order.address
    address.save
    end
    # binding.pry
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item_id
      @order_details.count = cart_item.total_count
      @order_details.tax_included_price = (cart_item.item.tax_excluded_price*1.08).floor
      @order_details.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_finish_path
  end

  def finish
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_payment, :order_status)
    end
end
