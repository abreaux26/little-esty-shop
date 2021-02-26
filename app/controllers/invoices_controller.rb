class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.find_from_merchant(@merchant.id)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @items_on_invoice = @invoice.items_on_invoice(@merchant.id)
  end
end
