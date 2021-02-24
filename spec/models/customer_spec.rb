require 'rails_helper'

RSpec.describe Customer do
  describe 'relationhips' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices)}
  end

  before :each do
    @customer = Customer.create!(first_name: "Jimmy", last_name: "Johns")
  end

  describe 'instance methods' do
    it 'returns full name of customer' do
      expect(@customer.full_name).to eq("Jimmy Johns")
    end 
  end
end
