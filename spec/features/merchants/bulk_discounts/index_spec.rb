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
    it 'I see a link to view all my discounts' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link("View All Discounts")
    end

    it 'I click discounts link and am taken to my bulk discounts index page' do
      visit merchant_dashboard_index_path(@merchant_1)
      click_link("View All Discounts")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    end

    it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
      visit merchant_bulk_discounts_path(@merchant_1)

      expect(page).to have_content(@bulk_discount_1.percentage_discount * 100)
      expect(page).to have_content(@bulk_discount_1.quantity_threshold)
      expect(page).to have_content(@bulk_discount_2.percentage_discount * 100)
      expect(page).to have_content(@bulk_discount_2.quantity_threshold)

      expect(page).not_to have_content(@bulk_discount_3.percentage_discount * 100)
      expect(page).not_to have_content(@bulk_discount_3.quantity_threshold)
      expect(page).not_to have_content(@bulk_discount_4.percentage_discount * 100)
      expect(page).not_to have_content(@bulk_discount_4.quantity_threshold)
    end

    it 'Each bulk discount listed includes a link to its show page' do
      visit merchant_bulk_discounts_path(@merchant_1)

      within("#bulk-discount-#{@bulk_discount_1.id}") do
        link = "#{@bulk_discount_1.percentage_discount * 100}% off #{@bulk_discount_1.quantity_threshold} items"

        expect(page).to have_link(link)
      end
    end
  end
end
