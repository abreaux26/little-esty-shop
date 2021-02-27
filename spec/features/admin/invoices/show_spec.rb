require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  before :each do
    setup
  end

  describe 'as an admin' do
    describe'displays invoice information' do
      it 'like id, status, created_at in Day, Month DD, YYYY' do
        visit admin_invoice_path(@invoice_1)

        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status_view_format)
        expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
      end
      it 'displays the total revenue of the invoice' do
        visit admin_invoice_path(@invoice_1)

        expect(page).to have_content("#{'%.2f' % @invoice_1.total_revenue}")
      end
    end

    describe'displays customer information' do
      it 'like full_name and shipping_address' do
        visit admin_invoice_path(@invoice_1)

        within '.admin_invoice#customer_info' do
          expect(page).to have_content(@customer_1.full_name)
        end
      end
    end

    describe'displays invoice_items information' do
      it 'like name, quantity, price, and status' do
        visit admin_invoice_path(@invoice_1)

        within '.admin_invoice#ii_info' do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@item_2.name)
          expect(page).to have_content(@item_3.name)
          expect(page).to have_content(@item_1.status)
          expect(page).to have_content(@item_2.status)
          expect(page).to have_content(@item_3.status)
          expect(page).to have_content(@item_1.unit_price)
          expect(page).to have_content(@item_2.unit_price)
          expect(page).to have_content(@item_3.unit_price)
        end
      end
    end
    describe "you can update an invoice status" do
      it 'has the invoice status as a select field with the current invoice selected' do
        visit admin_invoice_path(@invoice_2)
        # I see the invoice status is a select field
        # And I see that the invoice's current status is selected
      end
      it 'can pick a new status for the Invoice and see it updated on the Admin Invoice Show Page' do
        visit admin_invoice_path(@invoice_2)
        expect(page).to have_content(@invoice_2.status_view_format)
        expect(page).to have_content("SELECT FIELD")
        # When I click this select field,
        # Then I can select a new status for the Invoice,
        # And next to the select field I see a button to "Update Invoice Status"
        click_bitton("Update Invoice Status")
        expect(path).to eq(admin_invoice_path(@invoice_1))
        expect(page).to have_content("new status selection")
      end
    end
  end

  def setup
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 2, unit_price: 1.00)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 5.00)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 2, unit_price: 5.00)
    @invoice_2 = create(:invoice, status: :in_progress)
  end
end
