class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    customer_ids = invoices.joins(:transactions)
                           .where("transactions.result = 1")
                           .group(:id)
                           .order('count(transactions.result = 1) desc')
                           .limit(5)
                           .pluck(:customer_id)

    Customer.find(customer_ids)
  end

  def transaction_count(customer_id)
    transactions.where(result: 1, invoice_id: Invoice.where(customer_id: customer_id)).size
  end


end
