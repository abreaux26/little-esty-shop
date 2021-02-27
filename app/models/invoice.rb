class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  enum status: [:cancelled, :completed, :in_progress]

  def self.find_from(customer_id)
    where(customer_id: customer_id)
  end

  def status_view_format
    status.titleize
  end

  def created_at_view_format
    created_at.strftime('%A, %B %d, %Y')
  end

  def self.all_invoices_with_unshipped_items
    joins(:invoice_items)
    .where('invoice_items.status = ?', 1)
    .distinct(:id).order(:created_at)
  end

  def self.total_revenue(id)
     Invoice.joins(:invoice_items)
            .select("invoices.*, count('quantity*unit_price') as total_revenue")
            .group(:id).find(id).total_revenue
  end

  def self.find_from_merchant(merchant_id)
    joins(:items).where('items.merchant_id = ?', merchant_id)
  end

  def customer_full_name
    customer.full_name
  end

  def items_on_invoice(merchant_id)
    items.where(merchant_id: merchant_id)
  end

  def find_invoice_item(item_id)
    invoice_items.where(item_id: item_id).first
  end

  def invoice_item_quantity(item_id)
    find_invoice_item(item_id).quantity
  end

  def invoice_item_unit_price(item_id)
    find_invoice_item(item_id).unit_price_fix
  end

  def invoice_item_status(item_id)
    find_invoice_item(item_id).status
  end
end
