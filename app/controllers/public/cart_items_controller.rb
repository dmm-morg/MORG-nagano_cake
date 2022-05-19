class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items= current_customer.cart_items
    @cart_item = CartItem.new
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.total_count += params[:cart_item][:total_count].to_i
      cart_item.save
      redirect_to cart_items_path
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.save
      redirect_to cart_items_path
    end
  end


  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.delete
    redirect_to cart_items_path
  end

  def all_destroy
    current_customer.cart_items.all_destroy
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:total_count, :item_id)
  end

end
