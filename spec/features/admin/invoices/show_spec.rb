require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  before :each do
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
  end

  describe 'as an admin' do
    describe'displays invoice information' do
      it 'like id, status, created_at in Day, Month DD, YYYY' do
        visit admin_invoice_path(@invoice_1)


        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status_view_format)
        expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
      end
    end

    describe'displays customer information' do
      it 'like full_name and shipping_address' do
        visit admin_invoice_path(@invoice_1)


        expect(page).to have_content(@customer_1.full_name)
        expect(page).to have_content(@customer_1.shipping_address)
      end
    end
  end
end
