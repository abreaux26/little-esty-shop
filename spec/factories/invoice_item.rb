FactoryBot.define do
  factory :invoice_item do
    sequence :quantity do |n|
      n + 5
    end
    sequence :unit_price do |n|
      n + 1
    end
    status { "packaged" or "pending" or "shipped" }
    invoice
    item
  end
end
