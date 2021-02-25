class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.items.enabled
    @disabled_items = @merchant.items.disabled
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:success] = "Your Item Has Been Updated"
      if params[:status]
        redirect_to merchant_items_path(@merchant)
      else
        redirect_to merchant_item_path(@merchant, @item)
      end
    else
      flash[:error] = "Your Item Has Not Been Updated Due To Invalid Fields."
      render :edit
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
