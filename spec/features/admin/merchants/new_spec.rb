require 'rails_helper'

RSpec.describe 'Admin merchants new spec' do
  describe 'as an admin' do
    it 'loads with a form to create a new merchant' do
      visit new_admin_merchant_path

      within('#form') do
        fill_in('merchant_name', with: 'WPI Records')
        click_on 'submit'
      end

      expect(current_path).to eq(admin_merchants_path)

      within('#disabled-merchants') do
        expect(page).to have_content('WPI Records')
      end
    end

    it 'shows flash message if fields are saved blank' do
      visit new_admin_merchant_path

      within('#form') do
        fill_in('merchant_name', with: '')
        click_on 'submit'
      end

      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_selector('.flash-message')
    end
  end
end
