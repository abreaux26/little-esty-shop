class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:merchant_id])
  end
end
