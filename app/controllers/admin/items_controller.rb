class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.uppdate(item_params)
      redirect_to admin_item_path(@item)
    else
      render 'edit'
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :tax_excluded_price, :sales_status, :genre_id, :image)
  end

end
