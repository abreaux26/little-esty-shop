require 'rails_helper'

RSpec.describe 'Admin merchants show spec' do
  before :each do
    @merchant1 = create(:merchant)
  end

  describe 'as an admin' do
    it "loads with a form populated with merchant's info" do
      visit edit_admin_merchant_path(@merchant1)

      within('#form') do
        expect(page.find('#merchant_name').value).to eq(@merchant1.name)
        fill_in('merchant_name', with: 'WPI Records')
        click_on 'submit'
      end

      expect(current_path).to eq(admin_merchant_path(@merchant1))

      expect(page).to have_selector('.flash-message')
      within('#merchant-info') do
        expect(page).to have_content('WPI Records')
      end
    end
  end
end
