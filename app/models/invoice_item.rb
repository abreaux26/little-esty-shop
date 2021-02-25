class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]

  def item_find(item_id)
    Item.find(item_id)
  end

  def invoice_find(invoice_id)
    Invoice.find(invoice_id)
  end

  def self.search_for_quantity(invoiceid, itemid)
    select(:quantity).find_by(invoice_id: invoiceid, item_id: itemid).quantity
  end
end
