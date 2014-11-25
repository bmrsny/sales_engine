require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice_items'
require_relative 'invoice_items_repository'
require_relative 'invoices'
require_relative 'invocies_repository'
require_relative 'items'
require_relative 'items_repository'
require_relative 'transactions'
require_relative 'transactions_repository'

class SalesEngine
  attr_accessor :dir, :merchant_repository, :customer_repository, :invoice_repository,
                :transactions_repository, :invoice_items, :items_repository

  def initialize(dir="./data/")
    @dir = dir
    startup
  end

  def startup
    # merchant = Csv_handler.new("#{dir}merchants.csv")
    # Merchant_Repository.new(merchant.data)

    # customer = Csv_handler.new("#{dir}customers.csv")
    # Customer_Repository.new(customer.data)

    # invoice_items = Csv_handler.new("#{dir}invoice_itmes.csv")
    # Invoice_Items_Repository.new(invoice_items.data)

    # items = Csv_handler.new("#{dir}items.csv")
    # Items_Repository.new(items.data)

    # transactions = Csv_handler.new("#{dir}transactions.csv")
    # Transactions_Repository.new(transactions.data)

    # invoices = Csv_handler.new("#{dir}invoices.csv")
    # Invoices_Repository.new(invoices.data)
  end


end
