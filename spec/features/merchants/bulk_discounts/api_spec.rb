require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 15, merchant: @merchant_1)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant: @merchant_1)

    @bulk_discount_3 = BulkDiscount.create!(percentage_discount: 0.30, quantity_threshold: 12, merchant: @merchant_2)
    @bulk_discount_4 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 4, merchant: @merchant_2)
  end

  describe 'When I visit my merchant dashboard' do
    it "I see a section with a header of 'Upcoming Holidays'" do
      visit merchant_bulk_discounts_path(@merchant_1)

      within(".api") do
        expect(page).to have_content('Upcoming Holidays')
      end
    end

    it 'In this section the name and date of the next 3 upcoming US holidays are listed.' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within(".api") do
        expect(page).to have_content('Memorial Day')
        expect(page).to have_content('2021-05-31')

        expect(page).to have_content('Independence Day')
        expect(page).to have_content('2021-07-05')

        expect(page).to have_content('Labor Day')
        expect(page).to have_content('2021-09-06')
      end
    end
  end
end
