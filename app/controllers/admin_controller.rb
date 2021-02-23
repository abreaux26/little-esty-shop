class AdminController < ApplicationController

  def index
    @merchants = Merchant.all
    @invoices = Invoice.all
  end
end
