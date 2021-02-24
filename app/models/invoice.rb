class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  def self.all_invoices_with_unshipped_items
    joins(:invoice_items).where('invoice_items.status = ?', 1).distinct(:id)
  end
end
