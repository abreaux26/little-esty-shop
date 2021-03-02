class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(status: params[:status])

    merchant_id = params[:merchant_id]
    invoice_id = @invoice_item.invoice_id
    redirect_to merchant_invoice_path(merchant_id, invoice_id)
  end
end
