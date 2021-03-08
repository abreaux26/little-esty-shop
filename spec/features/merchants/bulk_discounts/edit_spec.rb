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

  describe 'When I visit my bulk discount show page' do
    it 'I see a link to edit the bulk discount' do
      visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      expect(page).to have_link("Edit")
    end

    it 'I click this link and am taken to a new page with a form to edit the discount' do
      visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      click_link("Edit")

      expect(page).to have_button('Submit')
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    end

    it 'I see that the discounts current attributes are pre-poluated in the form' do
      visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      expect(find_field(:percentage_discount).value).to eq '0.2'
      expect(find_field(:quantity_threshold).value).to eq '15'
    end

    it 'I change info and click submit and I am redirected to the bulk discounts show page' do
      visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      fill_in :percentage_discount, with: 0.45
      fill_in :quantity_threshold, with: 3

      click_button('Submit')

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    end

    it 'I see that the discounts attributes have been updated' do
      visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      fill_in :percentage_discount, with: 0.45
      fill_in :quantity_threshold, with: 3

      click_button('Submit')

      expect(page).to have_content("Percentage Discount: 45.0%")
      expect(page).to have_content("Quantity Threshold: 3")
    end
  end
end
