require 'rails_helper'

RSpec.describe 'Admin merchants index spec' do
  describe 'as an admin' do
    it 'shows name of each merchant in the system' do
      setup_basic_merchants
      visit admin_merchants_path

      within('#all-merchants') do
        expect(page).to have_content(@merchant_11.name)
        expect(page).to have_content(@merchant_12.name)
        expect(page).to have_content(@merchant_13.name)
        expect(page).to have_content(@merchant_14.name)
        expect(page).to have_content(@merchant_15.name)
        expect(page).to have_content(@merchant_16.name)
      end
    end

    it 'enabled merchants are grouped together' do
      setup_basic_merchants
      visit admin_merchants_path

      within('#enabled-merchants') do
        expect(page).to have_content('Enabled Merchants')
        expect(page).to have_content(@merchant_11.name)
        expect(page).to have_content(@merchant_12.name)
        expect(page).to have_content(@merchant_13.name)
      end
    end

    it 'disabled merchants are grouped together' do
      setup_basic_merchants
      visit admin_merchants_path

      within('#disabled-merchants') do
        expect(page).to have_content('Disabled Merchants')
        expect(page).to have_content(@merchant_14.name)
        expect(page).to have_content(@merchant_15.name)
        expect(page).to have_content(@merchant_16.name)
      end
    end

    it 'shows button to enable/disable merchant next to their name' do
      setup_basic_merchants
      visit admin_merchants_path

      within('#all-merchants') do
        expect(page).to have_button("disable-#{@merchant_11.id}")
        expect(page).to have_button("disable-#{@merchant_12.id}")
        expect(page).to have_button("disable-#{@merchant_13.id}")

        click_button("disable-#{@merchant_11.id}")
      end

      expect(current_path).to eq(admin_merchants_path)

      within('#all-merchants') do
        expect(page).to have_button("enable-#{@merchant_11.id}")
        expect(page).to have_button("disable-#{@merchant_12.id}")
        expect(page).to have_button("disable-#{@merchant_13.id}")
      end
    end

    it 'names of merchants are links to their show page' do
      setup_basic_merchants
      visit admin_merchants_path

      within('#all-merchants') do
        expect(page).to have_link(@merchant_11.name)
        expect(page).to have_link(@merchant_12.name)
        expect(page).to have_link(@merchant_13.name)

        # Only testing one merchant
        click_link @merchant_11.name
        expect(current_path).to eq admin_merchant_path(@merchant_11)
      end
    end

    it 'shows link to create a new merchant' do
      visit admin_merchants_path

      expect(page).to have_link('New Merchant')
      click_link('New Merchant')
      expect(current_path).to eq(new_admin_merchant_path)
    end

    describe 'top merchants section' do
      it 'shows top five merchants by revenue' do
        setup_top_five_revenue_merchants
        visit admin_merchants_path

        within('#top-merchants') do
          actual_ordered_text = page.all('.top-merchant').map(&:text)
          expected_ordered_names = ['Merchant 5', 'Merchant 4', 'Merchant 3', 'Merchant 2', 'Merchant 1']

          expect(actual_ordered_text.size).to eq(5)
          5.times do |i|
            expect(actual_ordered_text[i]).to include(expected_ordered_names[i])
          end
        end
      end

      it 'merchant names are links to their show pages' do
        setup_top_five_revenue_merchants
        visit admin_merchants_path

        within('#top-merchants') do
          actual_ordered_links = page.all('li a').map { |a| a['href'] }
          expected_ordered_links = [admin_merchant_path(@merchant_5),
                                    admin_merchant_path(@merchant_4),
                                    admin_merchant_path(@merchant_3),
                                    admin_merchant_path(@merchant_2),
                                    admin_merchant_path(@merchant_1)]

          expect(actual_ordered_links).to eq(expected_ordered_links)
        end
      end

      it 'shows total revenue next to merchant name' do
        setup_top_five_revenue_merchants
        visit admin_merchants_path

        within('#top-merchants') do
          actual_ordered_text = page.all('.top-merchant').map(&:text)
          expected_currency_strings = ["$#{@merchant_5.total_revenue.truncate}",
                                            "$#{@merchant_4.total_revenue.truncate}",
                                            "$#{@merchant_3.total_revenue.truncate}",
                                            "$#{@merchant_2.total_revenue.truncate}",
                                            "$#{@merchant_1.total_revenue.truncate}"]

          expect(actual_ordered_text.size).to eq(5)
          5.times do |i|
            expect(actual_ordered_text[i]).to include(expected_currency_strings[i])
          end
        end
      end

      it 'shows date with most revenue for each merchant' do
        merchant_8_with_history
        merchant_9_with_history
        merchant_10_with_history
        visit admin_merchants_path

        within('#top-merchants') do
          actual_best_day_text = page.all('.top-merchant-best-day').map(&:text)
          expected_best_day_strings = [@merchant_8.best_day.strftime('%A, %B %d, %Y'),
                                        @merchant_9.best_day.strftime('%A, %B %d, %Y'),
                                        @merchant_10.best_day.strftime('%A, %B %d, %Y')]

          expect(actual_best_day_text.size).to eq(3)
          3.times do |i|
            expect(actual_best_day_text[i]).to include(expected_best_day_strings[i])
          end
        end
      end
    end
  end

  def sample_date
    DateTime.new(2021, 01, 01)
  end

  def setup_basic_merchants
    @merchant_11 = create(:merchant, status: :enabled)
    @merchant_12= create(:merchant, status: :enabled)
    @merchant_13 = create(:merchant, status: :enabled)
    @merchant_14, @merchant_15, @merchant_16 = create_list(:merchant, 3)
  end

  def setup_top_five_revenue_merchants
    merchant_1_with_history
    merchant_2_with_history
    merchant_3_with_history
    merchant_4_with_history
    merchant_5_with_history
    merchant_6_with_history
    merchant_7_with_history
  end

  def merchant_1_with_history
    @merchant_1 = create(:merchant, name: 'Merchant 1')
    customer = create(:customer)
    item = @merchant_1.items.create!(name: 'Item', description: 'foo bar baz quux', unit_price: 10)
    invoice = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 10)
    Transaction.create!(invoice_id: invoice.id, result: Transaction.results[:success])
  end

  def merchant_2_with_history
    @merchant_2 = create(:merchant, name: 'Merchant 2')
    customer = create(:customer)
    item = @merchant_2.items.create!(name: 'Item', description: 'foo bar baz quux', unit_price: 10)
    invoice = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 20)
    Transaction.create!(invoice_id: invoice.id, result: Transaction.results[:success])
  end

  def merchant_3_with_history
    @merchant_3 = create(:merchant, name: 'Merchant 3')
    customer = create(:customer)
    item = @merchant_3.items.create!(name: 'Item', description: 'foo bar baz quux', unit_price: 20)
    invoice = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 30)
    Transaction.create!(invoice_id: invoice.id, result: Transaction.results[:success])
  end

  def merchant_4_with_history
    @merchant_4 = create(:merchant, name: 'Merchant 4')
    customer = create(:customer)
    item_1 = @merchant_4.items.create!(name: 'Item 1', description: 'foo bar baz quux', unit_price: 10)
    item_2 = @merchant_4.items.create!(name: 'Item 2', description: 'foo bar baz quux', unit_price: 20)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    invoice_2 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 40)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 40)
    # Note first transaction is failed
    Transaction.create!(invoice_id: invoice_1.id, result: Transaction.results[:failed])
    Transaction.create!(invoice_id: invoice_2.id, result: Transaction.results[:success])
  end

  def merchant_5_with_history
    @merchant_5 = create(:merchant, name: 'Merchant 5')
    customer = create(:customer)
    item_1 = @merchant_5.items.create!(name: 'Item 1', description: 'foo bar baz quux', unit_price: 10)
    item_2 = @merchant_5.items.create!(name: 'Item 2', description: 'foo bar baz quux', unit_price: 20)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    invoice_2 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 50)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50)
    # Note second transaction is failed
    Transaction.create!(invoice_id: invoice_1.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_2.id, result: Transaction.results[:failed])
  end

  def merchant_6_with_history
    @merchant_6 = create(:merchant, name: 'Merchant 6')
    customer = create(:customer)
    item = @merchant_6.items.create!(name: 'Item', description: 'foo bar baz quux', unit_price: 10)
    invoice = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 1)
    Transaction.create!(invoice_id: invoice.id, result: Transaction.results[:success])
  end

  def merchant_7_with_history
    @merchant_7 = create(:merchant, name: 'Merchant 7')
    customer = create(:customer)
    item = @merchant_7.items.create!(name: 'Item', description: 'foo bar baz quux', unit_price: 10)
    invoice = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed])
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 2)
    Transaction.create!(invoice_id: invoice.id, result: Transaction.results[:success])
  end

  def merchant_8_with_history
    # Merchant w/ best revenue day of `sample_date`
    @merchant_8 = create(:merchant, name: 'Merchant 8')
    customer = create(:customer)
    item_1 = @merchant_8.items.create!(name: 'Item 1', description: 'foo bar baz quux', unit_price: 10)
    item_2 = @merchant_8.items.create!(name: 'Item 2', description: 'foo bar baz quux', unit_price: 20)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: (sample_date + 1))
    invoice_2 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: (sample_date + 1))
    invoice_3 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: sample_date)
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 20)
    InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 2, unit_price: 50)
    Transaction.create!(invoice_id: invoice_1.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_2.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_3.id, result: Transaction.results[:success])
  end

  def merchant_9_with_history
    # Merchant w/ tie for best revenue days
    @merchant_9 = create(:merchant, name: 'Merchant 9')
    customer = create(:customer)
    item_1 = @merchant_9.items.create!(name: 'Item 1', description: 'foo bar baz quux', unit_price: 10)
    item_2 = @merchant_9.items.create!(name: 'Item 2', description: 'foo bar baz quux', unit_price: 20)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: (sample_date))
    invoice_2 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: (sample_date - 1))
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 10)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 20)
    Transaction.create!(invoice_id: invoice_1.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_2.id, result: Transaction.results[:success])
  end

  def merchant_10_with_history
    # Merchant w/ failed transaction on what would've been their best revenue day if the transaction succeeded
    @merchant_10 = create(:merchant, name: 'Merchant 10')
    customer = create(:customer)
    item_1 = @merchant_10.items.create!(name: 'Item 1', description: 'foo bar baz quux', unit_price: 10)
    item_2 = @merchant_10.items.create!(name: 'Item 2', description: 'foo bar baz quux', unit_price: 20)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: sample_date)
    invoice_2 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: sample_date)
    invoice_3 = Invoice.create!(customer_id: customer.id, status: Invoice.statuses[:completed], created_at: (sample_date + 1))
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 20)
    InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 10, unit_price: 10)
    Transaction.create!(invoice_id: invoice_1.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_2.id, result: Transaction.results[:success])
    Transaction.create!(invoice_id: invoice_3.id, result: Transaction.results[:failed])
  end
end
