require 'csv'

namespace :csv_load do

  def build(file, klass)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      attributes = row.to_hash
      attributes[:status].gsub!(' ', '_') unless attributes[:status].nil?
      klass.create!(attributes)
    end
  end

  task all: :environment do
    build("./db/data/customers.csv", Customer)
    build("./db/data/merchants.csv", Merchant)
    build("./db/data/items.csv", Item)
    build("./db/data/invoices.csv", Invoice)
    build("./db/data/invoice_items.csv", InvoiceItem)
    build("./db/data/transactions.csv", Transaction)
  end

  desc "TODO"
  task customers: :environment do
    build("./db/data/customers.csv", Customer)
  end

  desc "TODO"
  task invoice_items: :environment do
    build("./db/data/invoice_items.csv", InvoiceItem)
  end

  desc "TODO"
  task invoices: :environment do
    build("./db/data/invoices.csv", Invoice)
  end

  desc "TODO"
  task items: :environment do
    build("./db/data/items.csv", Item)
  end

  desc "TODO"
  task merchants: :environment do
    build("./db/data/merchants.csv", Merchant)
  end

  desc "TODO"
  task transactions: :environment do
    build("./db/data/transactions.csv", Transaction)
  end

end
