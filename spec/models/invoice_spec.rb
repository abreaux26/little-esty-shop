require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationhips' do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
    it { should have_many :transactions }
    it { should belong_to :customer }
  end

  before :each do
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @customer_1 = create(:customer, first_name: "Ace")
    @customer_2 = create(:customer, first_name: "Eli")
    @customer_3 = create(:customer)
    #customer_1 related vars
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
    @transaction_1 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_2.id)
    @ii_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, status: InvoiceItem.statuses[:packaged], quantity: 5, unit_price: 1.00)
    @ii_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id, status: InvoiceItem.statuses[:shipped], quantity: 5, unit_price: 2.00)
    @ii_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id, status: InvoiceItem.statuses[:shipped], quantity:10, unit_price: 5.00)
    #customer_2 related vars
    @invoice_4 = create(:invoice, customer_id: @customer_2.id)
    @invoice_5 = create(:invoice, customer_id: @customer_2.id)
    @invoice_21 = create(:invoice, customer_id: @customer_2.id)
    @invoice_22 = create(:invoice, customer_id: @customer_2.id)
    @transaction_21 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_21.id)
    @transaction_22 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_22.id)
    @ii_21 = create(:invoice_item, invoice_id: @invoice_21.id, item_id: @item_1.id, status: InvoiceItem.statuses[:packaged], quantity: 12, unit_price: 2.00)
    @ii_22 = create(:invoice_item, invoice_id: @invoice_22.id, item_id: @item_2.id, status: InvoiceItem.statuses[:shipped], quantity: 5, unit_price: 2.00)
    @ii_23 = create(:invoice_item, invoice_id: @invoice_21.id, item_id: @item_3.id, status: InvoiceItem.statuses[:shipped], quantity: 15, unit_price: 5.00)
    #customer_3 related vars
    @invoice_31 = create(:invoice, customer_id: @customer_3.id)
    @invoice_32 = create(:invoice, customer_id: @customer_3.id)
    @transaction_31 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_31.id)
    @transaction_32 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_32.id)
    @ii_31 = create(:invoice_item, invoice_id: @invoice_31.id, item_id: @item_4.id, status: InvoiceItem.statuses[:shipped], quantity: 12, unit_price: 2.00)
    @ii_32 = create(:invoice_item, invoice_id: @invoice_31.id, item_id: @item_5.id, status: InvoiceItem.statuses[:shipped], quantity: 15, unit_price: 5.00)

    @bulk_discount = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant: @merchant)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 15, merchant: @merchant)
    @bulk_discount_3 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 10, merchant: @merchant_2)
    @bulk_discount_4 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 15, merchant: @merchant_2)
  end

  describe 'instance methods' do
    describe '#status_view_format' do
      it "cleans up statuses so they are capitalize and have no symbols on view" do
        invoice_a = create(:invoice, status: Invoice.statuses[:cancelled])
        invoice_b = create(:invoice, status: Invoice.statuses[:completed])
        invoice_c = create(:invoice, status: Invoice.statuses[:in_progress])

        expect(invoice_a.status_view_format).to eq("Cancelled")
        expect(invoice_b.status_view_format).to eq("Completed")
        expect(invoice_c.status_view_format).to eq("In Progress")
      end
    end

    describe '#created_at_view_format' do
      it "cleans up statuses so they are capitalize and have no symbols on view" do
        invoice_a = create(:invoice, created_at: Time.new(2021, 2, 24))

        expect(invoice_a.created_at_view_format).to eq("Wednesday, February 24, 2021")
      end
    end

    describe '#customer_full_name' do
      it 'returns customers full name' do
        expect(@invoice_1.customer_full_name).to eq(@customer_1.full_name)
      end
    end

    describe '#total_revenue' do
      it 'returns total revenue from a specific invoice' do
        expect('%.2f' % @invoice_1.total_revenue).to eq('55.00')
      end
    end

    describe '#total_revenue_after_discounts' do
      it 'returns total revenue after discount is taken off for a specific invoice' do
        expect('%.2f' % @invoice_1.total_revenue_after_discounts).to eq('50.00')
      end

      it 'returns same number as total revenue if no discounts apply' do
        expect(@invoice_2.total_revenue_after_discounts).to eq(@invoice_2.total_revenue.first.to_f)
      end

      it 'returns total revenue after two discounts are applied' do
        invoice_item_1_revenue = @ii_21.quantity * @ii_21.unit_price
        take_off_1 = invoice_item_1_revenue * @bulk_discount.percentage_discount
        discount_revenue_1 = invoice_item_1_revenue - take_off_1

        invoice_item_2_revenue = @ii_23.quantity * @ii_23.unit_price
        take_off_2 = invoice_item_2_revenue * @bulk_discount_2.percentage_discount
        discount_revenue_2 = invoice_item_2_revenue - take_off_2

        expected = '%.2f' % (discount_revenue_1 + discount_revenue_2)

        expect('%.2f' % @invoice_21.total_revenue_after_discounts).to eq(expected)
      end

      it 'returns total revenue after one discounts is applied' do
        invoice_item_1_revenue = @ii_31.quantity * @ii_31.unit_price
        take_off_1 = invoice_item_1_revenue * @bulk_discount_3.percentage_discount
        discount_revenue_1 = invoice_item_1_revenue - take_off_1

        invoice_item_2_revenue = @ii_32.quantity * @ii_32.unit_price
        take_off_2 = invoice_item_2_revenue * @bulk_discount_3.percentage_discount
        discount_revenue_2 = invoice_item_2_revenue - take_off_2

        expected = '%.2f' % (discount_revenue_1 + discount_revenue_2)

        expect('%.2f' % @invoice_31.total_revenue_after_discounts).to eq(expected)
      end
    end
  end

  describe 'class methods' do
    describe '::all_invoices_with_unshipped_items' do
      it 'returns all invoices with unshipped items' do

        expect(Invoice.all_invoices_with_unshipped_items).to eq([@invoice_1, @invoice_21])
      end
    end
  end
end
