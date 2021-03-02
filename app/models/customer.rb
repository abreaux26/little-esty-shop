class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.all_successful_transactions_by_customer_count
    joins(:transactions)
    .where("transactions.result = ?", Transaction.results[:success])
    .select("customers.*, count('transactions') as successful_transactions_count")
    .group(:id)
    .order('successful_transactions_count desc')
    .limit(5)
  end

  def transaction_count
    transactions.where(result: :success).size
  end
end
