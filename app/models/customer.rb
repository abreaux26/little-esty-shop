class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.all_successful_transactions_count
    Customer.joins(:transactions).where("transactions.result = ?", 1).select("customers.*, count('transactions') as successful_transactions_count").group(:id)
  end
end
