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

  describe 'When I visit my bulk discounts index' do
    it 'next to each bulk discount I see a link to delete it' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within("#bulk-discount-#{@bulk_discount_1.id}") do
        expect(page).to have_link("Delete")
      end
    end

    it 'I click this link and am redirected back to the bulk discounts index page' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within("#bulk-discount-#{@bulk_discount_1.id}") do
        click_link("Delete")
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    end

    it 'I no longer see the discount listed' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within("#bulk-discount-#{@bulk_discount_1.id}") do
        click_link("Delete")
      end

      expect(page).not_to have_content("#{@bulk_discount_1.percentage_discount * 100}% off #{@bulk_discount_1.quantity_threshold} items")
    end
  end
end
