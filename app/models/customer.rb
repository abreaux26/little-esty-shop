class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def self.all_successful_transactions_count
    Customer.joins(:transactions).where("transactions.result = ?", 0).select("customers.*, count('transactions') as successful_transactions_count").group(:id)
  end
end
