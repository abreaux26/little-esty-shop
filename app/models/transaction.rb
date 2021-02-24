class Transaction < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices

  enum result: [ :success, :failed ]
end
