class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.find_from_merchant(@merchant.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
