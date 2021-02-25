require 'rails_helper'

RSpec.describe Item do
  describe 'relationhips' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  before :each do
    @merchant = create(:merchant)

    @item = create(:item, merchant_id: @merchant.id, status: :enabled)
    @item2 = create(:item, merchant_id: @merchant.id, status: :disabled)
  end

  describe 'class methods' do
    it 'returns enabled items' do
      expected = [@item]

      expect(Item.enabled).to eq(expected)
    end

    it 'returns disabled items' do
      expected = [@item2]

      expect(Item.disabled).to eq(expected)
    end
  end
end
