class Public::ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @items = Item.where(sales_status: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end


