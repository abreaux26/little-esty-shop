class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.items.enabled
    @disabled_items = @merchant.items.disabled
    @top_five_items = @merchant.top_five_items
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

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    new_item_id = Item.max_id
    @item = @merchant.items.new(id: new_item_id,
                                name: item_params[:name],
                                description: item_params[:description],
                                unit_price: item_params[:unit_price]
                              )
    if @item.save
      flash[:success] = "Your Item Has Been Created"
      redirect_to merchant_items_path(@merchant)
    else
      flash[:error] = "Your Item Has Not Been Created Due To Invalid Fields."
      render :new
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
