class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    customer_ids = invoices.joins(:transactions)
                           .where("transactions.result = 1")
                           .group(:customer_id)
                           .order('count(transactions.result = 1) desc')
                           .limit(5)
                           .pluck(:customer_id)

    Customer.find(customer_ids)
  end

  def transaction_count(customer_id)
    transactions.where(result: 1, invoice_id: Invoice.find_from(customer_id)).size
  end

  def items_ready_to_ship
    item_ids = invoice_items.where.not(status: :shipped).joins(:invoice).where('invoices.status = 1').pluck(:item_id)

    Item.find(item_ids)
  end

  def invoice_for_item_ready(item_id)
    invoice_items.where(item_id: item_id).pluck(:invoice_id).first
  end
end
