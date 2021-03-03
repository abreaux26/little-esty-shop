require 'rails_helper'

RSpec.describe 'Admin merchants edit spec' do
  before :each do
    @merchant = create(:merchant)
  end

  describe 'as an admin' do
    it "loads with a form populated with merchant's info" do
      visit edit_admin_merchant_path(@merchant)

      within('#form') do
        expect(page.find('#merchant_name').value).to eq(@merchant.name)
        fill_in('merchant_name', with: 'WPI Records')
        click_on 'submit'
      end

      expect(current_path).to eq(admin_merchant_path(@merchant))

      expect(page).to have_selector('.flash-message')
      within('#merchant-info') do
        expect(page).to have_content('WPI Records')
      end
    end

    it 'shows flash message if fields are saved blank' do
      visit edit_admin_merchant_path(@merchant)

      within('#form') do
        fill_in('merchant_name', with: '')
        click_on 'submit'
      end

      expect(current_path).to eq(edit_admin_merchant_path(@merchant))
      expect(page).to have_selector('.flash-message')
    end
  end
end
