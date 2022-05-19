class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
    @order = Order.new
    
  end

  def confirm
  end

  def create
  end

  def finish
  end

  def index
  end

  def show
  end

end
