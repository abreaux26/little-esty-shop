require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = create(:merchant)
    @invoice = create(:invoice)
  end

  describe 'When I visit my merchants invoice show page(/merchants/merchant_id/invoices/invoice_id)' do
    it 'I see information related to that invoice' do
      visit merchant_invoice_path(@merchant, @invoice)

      expect(page).to have_content(@invoice.id)
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content(@invoice.created_at.strftime('%A, %B %d, %Y'))
    end
  end
end
