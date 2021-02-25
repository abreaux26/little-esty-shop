class AdminController < ApplicationController

  def index
    @top_customers = Customer.all_successful_transactions_by_customer_count
    @incomplete_invoices = Invoice.all_invoices_with_unshipped_items
  end
end
