class InvoiceItemsController < ApplicationController
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice = Invoice.find(@invoice_item.invoice_id)
    @invoice_item.update(status: params[:status])

    redirect_to merchant_invoice_path(@merchant, @invoice)
  end
end
