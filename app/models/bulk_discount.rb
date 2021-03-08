class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold
  validates_numericality_of :quantity_threshold

  belongs_to :merchant

  def self.order_by_quantity_threshold
    order(quantity_threshold: :desc)
  end
end
