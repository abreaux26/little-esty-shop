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

  # def orig_take_off
  #   invoice_items
  #   .joins(:bulk_discounts)
  #   .select('max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount) as take_off')
  #   .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
  #   .order('bulk_discounts.percentage_discount desc, bulk_discounts.quantity_threshold')
  #   .group('invoice_items.id, bulk_discounts.percentage_discount, bulk_discounts.quantity_threshold')
  #   .pluck(Arel.sql('max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount) as take_off'))
  # end

  # def orig_total_discount
  #   take_off[0..1].sum
  # end

  def take_off
    invoice_items
    .joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .group('invoice_items.id')
    .pluck(Arel.sql('max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount)'))
  end

  def total_discount
    take_off.sum
  end

  # def total_revenue_after_discounts
  #   invoice_items.sum(&:revenue_after_discount)
  # end
  
  def total_revenue_after_discounts
    total_revenue.first.to_f - total_discount.to_f
  end

end
