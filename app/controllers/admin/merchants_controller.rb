class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
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
    else
      merchant.update!(merchant_params)
      flash[:notification] = 'Merchant successfully updated!'
    end

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
