class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  belongs_to :customer

  enum status: [:cancelled, :completed, :in_progress]

  def created_at_view_format
    created_at.strftime('%A, %B %d, %Y')
  end

  def self.all_invoices_with_unshipped_items
    joins(:invoice_items)
    .where('invoice_items.status = ?', 1)
    .distinct(:id)
    .order(:created_at)
  end

  def customer_full_name
    customer.full_name
  end

  def total_revenue
    invoice_items.pluck(Arel.sql("sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue"))
  end

  def take_off
    invoice_items
    .joins(:bulk_discounts)
    .select('invoice_items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue,
    max(bulk_discounts.percentage_discount) as discount,
    sum(invoice_items.quantity * invoice_items.unit_price) * max(bulk_discounts.percentage_discount) as take_off')
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .order('bulk_discounts.quantity_threshold desc')
    .group('bulk_discounts.id')
    .pluck(Arel.sql("sum(invoice_items.quantity * invoice_items.unit_price) * max(bulk_discounts.percentage_discount) as take_off"))
  end

  def total_revenue_after_discounts
    total_revenue.first.to_f - take_off.first.to_f
  end
end
