class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:merchant_id].id)
  end
end
