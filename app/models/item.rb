class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 15, maximum: 500 }
  validates :unit_price, numericality: true

  enum status: [:disabled, :enabled]

  def self.enabled
    where(status: :enabled)
  end

  def self.disabled
    where(status: :disabled)
  end

  def self.max_id
    maximum(:id) + 1
  end
end
