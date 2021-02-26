class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.by_status(:enabled)
    @disabled_merchants = Merchant.by_status(:disabled)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if params[:status]
      merchant.update!(status_param)
      redirect_to admin_merchants_path
    else
      merchant.update!(merchant_params)
      flash[:notification] = 'Merchant successfully updated!'
      redirect_to admin_merchant_path(merchant.id)
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save

    redirect_to admin_merchants_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def status_param
    params.permit(:status)
  end
end
