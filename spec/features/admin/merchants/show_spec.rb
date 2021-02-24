require 'rails_helper'

RSpec.describe 'Admin merchants show spec' do
  before :each do
    @merchant1 = create(:merchant)
  end

  describe 'as an admin' do
    it 'shows name of the merchant' do
      visit admin_merchant_path(@merchant1)

      within('#merchant-info') do
        expect(page).to have_content(@merchant1.name)
      end
    end

    it 'shows a link to update the merchant' do
      visit admin_merchant_path(@merchant1)

      within('#merchant-info') do
        expect(page).to have_link('Update')
        click_link('Update')
        expect(current_path).to eq(edit_admin_merchant_path(@merchant1))
      end
    end
  end
end
