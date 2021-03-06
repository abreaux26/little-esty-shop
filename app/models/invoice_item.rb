class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.search_for_quantity(invoiceid, itemid)
    find_by(invoice_id: invoiceid, item_id: itemid)
    .quantity
  end

  def self.find_all_by_invoice(invoice_id)
    where(invoice_id: invoice_id)
  end

  def item_name
    item.name
  end

  def invoice_date
    invoice.created_at_view_format
  end

  def discount
    bulk_discounts
    .where('? >= bulk_discounts.quantity_threshold', quantity)
    .order('bulk_discounts.percentage_discount desc, bulk_discounts.quantity_threshold')
    .first
  end

  def revenue
    quantity * unit_price
  end

  def take_off
    return 0 if discount.nil?
    revenue * discount.percentage_discount
  end

  def revenue_after_discount
    revenue - take_off
  end
end
