require 'rails_helper'

RSpec.describe Customer do
  describe 'relationhips' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices)}
  end

  before :each do
    @customer_1 = create(:customer, first_name: "Jimmy", last_name: "Johns")
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @transaction_1 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_2.id)

    @customer_2 = create(:customer)
    @invoice_21 = create(:invoice, customer_id: @customer_2.id)
    @invoice_22 = create(:invoice, customer_id: @customer_2.id)
    @transaction_21 = create(:transaction, result: Transaction.results[:success], invoice_id: @invoice_21.id)

    @customer_3 = create(:customer)
    @invoice_31 = create(:invoice, customer_id: @customer_3.id)
    @invoice_32 = create(:invoice, customer_id: @customer_3.id)
    @transaction_31 = create(:transaction, result: Transaction.results[:failed], invoice_id: @invoice_31.id)
  end

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns full name of customer' do
        expect(@customer_1.full_name).to eq("Jimmy Johns")
      end
    end
  end

  describe 'class methods' do
    describe '::all_successful_transactions_by_customer_count' do
      it "returns distinct customers with unshipped items" do
        expect(Customer.all_successful_transactions_by_customer_count.first.id).to eq(@customer_1.id)
        expect(Customer.all_successful_transactions_by_customer_count.all[1].id).to eq(@customer_2.id)
        expect(Customer.all_successful_transactions_by_customer_count.first.successful_transactions_count).to eq(2)
        expect(Customer.all_successful_transactions_by_customer_count.all[1].successful_transactions_count).to eq(1)
      end
    end
  end
end
