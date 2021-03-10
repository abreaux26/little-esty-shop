require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationhips' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of :quantity_threshold }
  end

  before :each do
      @merchant_1 = create(:merchant)

      @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 15, merchant: @merchant_1)
      @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant: @merchant_1)

      @bulk_discount_3 = BulkDiscount.create!(percentage_discount: 0.30, quantity_threshold: 12, merchant: @merchant_1)
      @bulk_discount_4 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 4, merchant: @merchant_1)
    end

  describe 'class methods' do
    describe "::order" do
      it 'returns discounts in order from highest percentage discount to lowest' do
        expected = [@bulk_discount_3, @bulk_discount_1, @bulk_discount_2, @bulk_discount_4]
        expect(BulkDiscount.order_by).to eq(expected)
      end
    end
  end
end
