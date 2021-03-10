class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold
  validates_numericality_of :quantity_threshold

  belongs_to :merchant

  def self.order_by
    order('bulk_discounts.percentage_discount desc, bulk_discounts.quantity_threshold')
  end
end
