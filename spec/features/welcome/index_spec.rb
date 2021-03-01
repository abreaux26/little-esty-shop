require 'rails_helper'

RSpec.describe "Merchant Dashboard Index (welcome/landing page)" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end

  describe "as a user" do
    it "it should display all Merchant ids and names and link to their dashboard" do

      visit welcome_merchants_path

      within ".merchant_landing_page#merchant-#{@merchant_1.id}" do
        expect(page).to have_link("Merchant #{@merchant_1.id}: #{@merchant_1.name}")
        click_on("Merchant #{@merchant_1.id}: #{@merchant_1.name}")
        expect(current_path).to eq(merchant_dashboard_index_path(@merchant_1))
      end

      visit welcome_merchants_path

      within ".merchant_landing_page#merchant-#{@merchant_2.id}" do
        expect(page).to have_link("Merchant #{@merchant_2.id}: #{@merchant_2.name}")
        click_on("Merchant #{@merchant_2.id}: #{@merchant_2.name}")
        expect(current_path).to eq(merchant_dashboard_index_path(@merchant_2))
      end

      visit welcome_merchants_path

      within ".merchant_landing_page#merchant-#{@merchant_3.id}" do
        expect(page).to have_link("Merchant #{@merchant_3.id}: #{@merchant_3.name}")
        click_on("Merchant #{@merchant_3.id}: #{@merchant_3.name}")
        expect(current_path).to eq(merchant_dashboard_index_path(@merchant_3))
      end
    end
  end
end
