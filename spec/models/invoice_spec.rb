require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationhips' do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
    it { should belong_to :customer }
  end

  before :each do
    @customer_1 = create(:customer, first_name: "Ace")
    @customer_2 = create(:customer, first_name: "Eli")

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, customer_id: @customer_2.id)
    @invoice_5 = create(:invoice, customer_id: @customer_2.id)
  end

  describe 'class methods' do
    it 'returns invoices that belong to a specific customer' do
      expected = [@invoice_1, @invoice_2, @invoice_3]

      expect(Invoice.find_from(@customer_1.id)).to eq(expected)
    end
  end
end
