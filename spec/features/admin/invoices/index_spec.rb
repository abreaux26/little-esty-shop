require 'rails_helper'

RSpec.describe 'Admin invoices index spec' do
  before :each do
    @invoice1, @invoice2, @invoice3 = create_list(:invoice, 3)
  end

  describe 'as an admin' do
    it 'shows id# of each invoice in the system' do
      visit admin_invoices_path

      within('#all-invoices') do
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice2.id)
        expect(page).to have_content(@invoice3.id)
      end
    end

    it 'ids of invoices are links to their show page' do
      visit admin_invoices_path

      within('#all-invoices') do
        expect(page).to have_link(@invoice1.id)
        expect(page).to have_link(@invoice2.id)
        expect(page).to have_link(@invoice3.id)

        # Only testing one invoice
        click_link @invoice1.id
        expect(current_path).to eq admin_invoice_path(@invoice1)
      end
    end
  end
end
