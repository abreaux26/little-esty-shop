class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { maximum: 256 }
  validates :unit_price, numericality: true
end
