require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  before :each do
    @customer_1 = create(:customer, first_name: "Ace")
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, customer_id: @customer_1.id)
    @invoice_5 = create(:invoice, customer_id: @customer_1.id)
    @transaction_1 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_2.id)
    @transaction_3 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_3.id)
    @transaction_4 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_4.id)
    @transaction_5 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_5.id)

    ii_1 = create(:invoice_item, invoice_id: @invoice_1.id, status: InvoiceItem.statuses[:packaged])
    ii_2 = create(:invoice_item, invoice_id: @invoice_1.id, status: InvoiceItem.statuses[:packaged])
    ii_3 = create(:invoice_item, invoice_id: @invoice_2.id, status: InvoiceItem.statuses[:shipped])
    ii_4 = create(:invoice_item, invoice_id: @invoice_2.id, status: InvoiceItem.statuses[:shipped])
    ii_5 = create(:invoice_item, invoice_id: @invoice_3.id, status: InvoiceItem.statuses[:packaged])


    @customer_2 = create(:customer, first_name: "Eli")
    @invoice_21 = create(:invoice, customer_id: @customer_2.id)
    @invoice_22 = create(:invoice, customer_id: @customer_2.id)
    @invoice_23 = create(:invoice, customer_id: @customer_2.id)
    @invoice_24 = create(:invoice, customer_id: @customer_2.id)
    @invoice_25 = create(:invoice, customer_id: @customer_2.id)
    @transaction_21 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_21.id)
    @transaction_22 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_22.id)
    @transaction_23 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_23.id)
    @transaction_24 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_24.id)
    @transaction_25 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_25.id)

    ii_21 = create(:invoice_item, invoice_id: @invoice_24.id, status: InvoiceItem.statuses[:packaged])

    @customer_3 = create(:customer, first_name: "Danny")
    @invoice_31 = create(:invoice, customer_id: @customer_3.id)
    @invoice_32 = create(:invoice, customer_id: @customer_3.id)
    @invoice_33 = create(:invoice, customer_id: @customer_3.id)
    @invoice_34 = create(:invoice, customer_id: @customer_3.id)
    @invoice_35 = create(:invoice, customer_id: @customer_3.id)
    @transaction_31 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_31.id)
    @transaction_32 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_32.id)
    @transaction_33 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_33.id)
    @transaction_34 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_34.id)
    @transaction_35 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_35.id)

    @customer_4 = create(:customer, first_name: "Cate")
    @invoice_41 = create(:invoice, customer_id: @customer_4.id)
    @invoice_42 = create(:invoice, customer_id: @customer_4.id)
    @invoice_43 = create(:invoice, customer_id: @customer_4.id)
    @invoice_44 = create(:invoice, customer_id: @customer_4.id)
    @invoice_45 = create(:invoice, customer_id: @customer_4.id)
    @transaction_41 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_41.id)
    @transaction_42 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_42.id)
    @transaction_43 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_43.id)
    @transaction_44 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_44.id)
    @transaction_45 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_45.id)

    @customer_5 = create(:customer, first_name: "Bob")
    @invoice_51 = create(:invoice, customer_id: @customer_5.id)
    @invoice_52 = create(:invoice, customer_id: @customer_5.id)
    @invoice_53 = create(:invoice, customer_id: @customer_5.id)
    @invoice_54 = create(:invoice, customer_id: @customer_5.id)
    @invoice_55 = create(:invoice, customer_id: @customer_5.id)
    @transaction_51 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_51.id)
    @transaction_52 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_52.id)
    @transaction_53 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_53.id)
    @transaction_54 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_54.id)
    @transaction_55 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_55.id)

    customer_6 = create(:customer)

  end
  describe "displays basic information" do
    it "should have a header indicating it is the Admin Dashboard" do
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end

    it "should have links to the Admin merchant and invoice index" do
      visit admin_index_path

      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
      visit admin_index_path

      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
  describe "overall admin level statistics" do
    describe "top customer" do
      it "should list the top 5 customers (largest no. of successful transactions)" do
        visit admin_index_path

        cust1 = page.body.index(@customer_1.first_name)
        cust2 = page.body.index(@customer_2.first_name)
        cust3 = page.body.index(@customer_3.first_name)
        cust4 = page.body.index(@customer_4.first_name)
        cust5 = page.body.index(@customer_5.first_name)

        expect(cust1).to be < cust5
        expect(cust1).to be < cust4
        expect(cust1).to be < cust3
        expect(cust1).to be < cust2
        expect(cust5).to be < cust4
        expect(cust5).to be < cust3
        expect(cust5).to be < cust2
        expect(cust4).to be < cust3
        expect(cust4).to be < cust2
        expect(cust3).to be < cust2
      end
    end

    describe "Incomplete Invoices" do

      it "should list the ids and created date of the invoices that have
      unshipped items" do
        visit admin_index_path

        within ".incomplete_invoices" do

          expect(page).to have_content("#{@invoice_1.id}")
          expect(page).to have_content("#{@invoice_3.id}")
          expect(page).to have_content("#{@invoice_24.id}")
          expect(page).to_not have_content("#{@invoice_2.id}")
          expect(page).to_not have_content("#{@invoice_4.id}")
        end
      end
      it "should display the date formatted like 'Monday, July 18, 2019'" do
        visit admin_index_path

        expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(@invoice_3.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(@invoice_24.created_at.strftime('%A, %B %d, %Y'))
      end
      it "should link to the admin/show page when the id is clicked" do
        visit admin_index_path

        find_link("#{@invoice_1.id}")
        find_link("#{@invoice_3.id}")
        find_link("#{@invoice_24.id}")
      end
      it "should list the invoice ids from oldest to newest" do
        visit admin_index_path

        expect("#{@invoice_1.id}").to appear_before("#{@invoice_3.id}", only_text: true)
        expect("#{@invoice_3.id}").to appear_before("#{@invoice_24.id}", only_text: true)
      end
    end
  end
end
