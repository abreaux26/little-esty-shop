require 'rails_helper'

RSpec.describe 'As a merchant' do
  before :each do
    @merchant = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
  end

  describe 'When I visit my merchants invoice show page(/merchants/merchant_id/invoices/invoice_id)' do
    it 'I see information related to that invoice' do
      visit merchant_invoice_path(@merchant, @invoice_1)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
    end

    it 'I see all of the customer information related to that invoice' do
      visit merchant_invoice_path(@merchant, @invoice_1)

      expect(page).to have_content(@customer_1.full_name)
      expect(page).not_to have_content(@customer_2.full_name)
    end
  end
end
