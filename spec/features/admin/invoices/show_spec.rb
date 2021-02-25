require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  before :each do
    @invoice_1 = create(:invoice)
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
  end
end
