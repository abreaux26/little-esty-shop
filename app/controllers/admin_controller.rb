class AdminController < ApplicationController

  def index
    @merchants = Merchant.all
    @invoices = Invoice.all
    @top_customers = Customer.all_successful_transactions_count.order('successful_transactions_count desc').limit(5)
  end
end
