class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold
  validates_numericality_of :quantity_threshold

  belongs_to :merchant
end
