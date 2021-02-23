require 'rails_helper'

RSpec.describe 'Admin Merchants index spec' do
  before :each do
    @merchant1, @merchant2, @merchant3 = create_list(:merchant, 3)
  end

  describe 'as an admin' do
    it 'shows name of each merchant in the system' do
      visit admin_merchants_path

      within('#all-merchants') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_content(@merchant2.name)
        expect(page).to have_content(@merchant3.name)
      end
    end
  end
end
