require "rails_helper"

RSpec.describe 'As a merchant' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 15, merchant: @merchant_1)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant: @merchant_1)

    @bulk_discount_3 = BulkDiscount.create!(percentage_discount: 0.30, quantity_threshold: 12, merchant: @merchant_2)
    @bulk_discount_4 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 4, merchant: @merchant_2)
  end

  describe 'When I visit my bulk discount index page' do
    it 'I click the bulk discount link and it takes me to the show page' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within("#bulk-discount-#{@bulk_discount_1.id}") do
        click_link("#{@bulk_discount_1.percentage_discount * 100}% off #{@bulk_discount_1.quantity_threshold} items")
      end

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    end
  end


  describe 'When I visit my bulk discount show page' do
    it 'I see the bulk discounts quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      expect(page).to have_content(@bulk_discount_1.percentage_discount * 100)
      expect(page).to have_content(@bulk_discount_1.quantity_threshold)
    end
  end
end
