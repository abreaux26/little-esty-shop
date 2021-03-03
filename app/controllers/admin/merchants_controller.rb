class Admin::MerchantsController < ApplicationController
  def index
    # TODO refactor using facade pattern?
    @merchants = Merchant.all
    @enabled_merchants = Merchant.by_status(:enabled)
    @disabled_merchants = Merchant.by_status(:disabled)
    @top_five_merchants = Merchant.top_five_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    if params[:status]
      update_status_only
    else
      update_entire_merchant
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
    else
      flash[:error] = "Merchant not created due to invalid input."
      redirect_to new_admin_merchant_path
    end
  end

  private

  def update_entire_merchant
    merchant = Merchant.find(params[:id])

    begin
      merchant.update!(merchant_params)
      flash[:notification] = 'Merchant successfully updated!'
      redirect_to admin_merchant_path(merchant)
    rescue
      flash[:error] = 'Merchant failed to updated!'
      redirect_to edit_admin_merchant_path(merchant)
    end
  end

  def update_status_only
    merchant = Merchant.find(params[:id])

    merchant.update!(status_param)
    redirect_to admin_merchants_path
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def status_param
    params.permit(:status)
  end
end
