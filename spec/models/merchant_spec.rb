require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationhips' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
  end

  before :each do
   @customer_1 = create(:customer, first_name: "Ace")

   @invoice_1 = create(:invoice, customer_id: @customer_1.id)
   @invoice_2 = create(:invoice, customer_id: @customer_1.id)
   @invoice_3 = create(:invoice, customer_id: @customer_1.id)
   @invoice_4 = create(:invoice, customer_id: @customer_1.id)
   @invoice_5 = create(:invoice, customer_id: @customer_1.id)

   @transaction_1 = create(:transaction, result: "success", invoice_id: @invoice_1.id)
   @transaction_2 = create(:transaction, result: "success", invoice_id: @invoice_2.id)
   @transaction_3 = create(:transaction, result: "success", invoice_id: @invoice_3.id)
   @transaction_4 = create(:transaction, result: "success", invoice_id: @invoice_4.id)
   @transaction_5 = create(:transaction, result: "success", invoice_id: @invoice_5.id)

   @customer_2 = create(:customer, first_name: "Eli")
   @invoice_21 = create(:invoice, customer_id: @customer_2.id)
   @invoice_22 = create(:invoice, customer_id: @customer_2.id)
   @invoice_23 = create(:invoice, customer_id: @customer_2.id)
   @invoice_24 = create(:invoice, customer_id: @customer_2.id)
   @invoice_25 = create(:invoice, customer_id: @customer_2.id)

   @transaction_21 = create(:transaction, result: "failed", invoice_id: @invoice_21.id)
   @transaction_22 = create(:transaction, result: "failed", invoice_id: @invoice_22.id)
   @transaction_23 = create(:transaction, result: "failed", invoice_id: @invoice_23.id)
   @transaction_24 = create(:transaction, result: "success", invoice_id: @invoice_24.id)
   @transaction_25 = create(:transaction, result: "failed", invoice_id: @invoice_25.id)

   @customer_3 = create(:customer, first_name: "Danny")
   @invoice_31 = create(:invoice, customer_id: @customer_3.id)
   @invoice_32 = create(:invoice, customer_id: @customer_3.id)
   @invoice_33 = create(:invoice, customer_id: @customer_3.id)
   @invoice_34 = create(:invoice, customer_id: @customer_3.id)
   @invoice_35 = create(:invoice, customer_id: @customer_3.id)

   @transaction_31 = create(:transaction, result: "failed", invoice_id: @invoice_31.id)
   @transaction_32 = create(:transaction, result: "success", invoice_id: @invoice_32.id)
   @transaction_33 = create(:transaction, result: "success", invoice_id: @invoice_33.id)
   @transaction_34 = create(:transaction, result: "failed", invoice_id: @invoice_34.id)
   @transaction_35 = create(:transaction, result: "failed", invoice_id: @invoice_35.id)

   @customer_4 = create(:customer, first_name: "Cate")
   @invoice_41 = create(:invoice, customer_id: @customer_4.id)
   @invoice_42 = create(:invoice, customer_id: @customer_4.id)
   @invoice_43 = create(:invoice, customer_id: @customer_4.id)
   @invoice_44 = create(:invoice, customer_id: @customer_4.id)
   @invoice_45 = create(:invoice, customer_id: @customer_4.id)

   @transaction_41 = create(:transaction, result: "success", invoice_id: @invoice_41.id)
   @transaction_42 = create(:transaction, result: "success", invoice_id: @invoice_42.id)
   @transaction_43 = create(:transaction, result: "success", invoice_id: @invoice_43.id)
   @transaction_44 = create(:transaction, result: "failed", invoice_id: @invoice_44.id)
   @transaction_45 = create(:transaction, result: "failed", invoice_id: @invoice_45.id)

   @customer_5 = create(:customer, first_name: "Bob")
   @invoice_51 = create(:invoice, customer_id: @customer_5.id)
   @invoice_52 = create(:invoice, customer_id: @customer_5.id)
   @invoice_53 = create(:invoice, customer_id: @customer_5.id)
   @invoice_54 = create(:invoice, customer_id: @customer_5.id)
   @invoice_55 = create(:invoice, customer_id: @customer_5.id)

   @transaction_51 = create(:transaction, result: "success", invoice_id: @invoice_51.id)
   @transaction_52 = create(:transaction, result: "success", invoice_id: @invoice_52.id)
   @transaction_53 = create(:transaction, result: "success", invoice_id: @invoice_53.id)
   @transaction_54 = create(:transaction, result: "success", invoice_id: @invoice_54.id)
   @transaction_55 = create(:transaction, result: "failed", invoice_id: @invoice_55.id)

   customer_6 = create(:customer)
   customer_7 = create(:customer)
   customer_8 = create(:customer)
   customer_9 = create(:customer)
   customer_10 = create(:customer)
  end

  describe 'instance methods' do
    it 'finds the top five customers' do
      expect(@merchant.top_five_customers).to eq([])
    end

    xit 'finds transaction count given a customer_id' do
      expect(@merchant.transaction_count(@customer.id)).to eq()
    end
  end
end
