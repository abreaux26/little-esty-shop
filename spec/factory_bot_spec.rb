require 'rails_helper'

RSpec.describe "As a Factory Bot" do
  it "can create dummy objects to use for testing" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item)

    expect(merchant.class).to eq(Merchant)
    expect(customer.class).to eq(Customer)
    expect(item.class).to eq(Item)
  end
end
