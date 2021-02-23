require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = Merchant.create!(name: 'New Merchant')
  end

  describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)' do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant)

      expect(current_path).to eq("/merchants/#{@merchant.id}/dashboard")

      expect(page).to have_content(@merchant.name)
    end
  end
end
