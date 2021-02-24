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
    if status == "in_progress"
      "In Progress"
    else
      status.capitalize
    end
  end

  def created_at_view_format
    created_at.strftime('%A, %B %d, %Y')
  end

  def self.all_invoices_with_unshipped_items
    joins(:invoice_items).where('invoice_items.status = ?', 1).distinct(:id).order(:created_at)
  end
end
