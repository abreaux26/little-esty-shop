class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def full_name
    "#{first_name} #{last_name}"
  end
end
