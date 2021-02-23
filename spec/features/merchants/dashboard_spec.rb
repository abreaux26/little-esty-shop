require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = Merchant.create!(name: 'New Merchant')
  end

  describe 'When I visit my merchant dashboard (/merchant/merchant_id/dashboard)' do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant)

      expect(current_path).to eq("/merchant/#{@merchant.id}/dashboard")

      expect(page).to have_content(@merchant.name)
    end

    it 'I see link to my merchant items index (/merchant/merchant_id/items)' do
      visit merchant_dashboard_index_path(@merchant)

      within(".nav") do
        expect(page).to have_link('My Items')
        click_link('My Items')
        expect(current_path).to eq(merchant_items_path(@merchant))
      end
    end

    it 'I see a link to my merchant invoices index (/merchant/merchant_id/invoices)' do
      visit merchant_dashboard_index_path(@merchant)

      within(".nav") do
        expect(page).to have_link('My Invoices')
        click_link('My Invoices')
        expect(current_path).to eq(merchant_invoices_path(@merchant))
      end
    end
  end
end
