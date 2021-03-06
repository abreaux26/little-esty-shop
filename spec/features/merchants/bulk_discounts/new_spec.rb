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

  describe 'When I visit my bulk discounts index' do
    it 'I see a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant_1)

      expect(page).to have_link("Create New Discount")
    end

    it 'I click this link and am taken to a new page where I see a form to add a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant_1)

      click_link("Create New Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
      expect(page).to have_button("Submit")
    end

    it 'I fill in the form with valid data and am redirected back to the bulk discount index' do
      visit new_merchant_bulk_discount_path(@merchant_1)

      fill_in :percentage_discount, with: 0.60
      fill_in :quantity_threshold, with: 25

      click_button("Submit")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    end

    it 'I fill in the form with invalid data' do
      visit new_merchant_bulk_discount_path(@merchant_1)

      click_button("Submit")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    end

    it 'I see my new bulk discount listed' do
      visit new_merchant_bulk_discount_path(@merchant_1)

      fill_in :percentage_discount, with: 0.60
      fill_in :quantity_threshold, with: 25

      click_button("Submit")

      expect(page).to have_content("60.0% off 25 items")
    end
  end
end
