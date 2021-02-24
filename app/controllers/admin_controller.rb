class AdminController < ApplicationController

  def index
    @top_customers = Customer.all_successful_transactions_count.order('successful_transactions_count desc').limit(5)
    @incomplete_invoices = Invoices.all_incomplete_invoices
  end
end
