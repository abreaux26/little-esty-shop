class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  enum status: ['cancelled', 'completed', 'in progress']

  def self.find_from(customer_id)
    where(customer_id: customer_id)
  end
end
