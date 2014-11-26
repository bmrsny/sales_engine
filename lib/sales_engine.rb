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
  attr_accessor :dir

  def initialize(dir="./data/")
    @dir = dir
    #startup
  end

  def startup
    merchant_objects = CsvHandler.new("#{dir}merchants.csv").build_merchants
    @merchant_repository ||= MerchantRepository.new(merchant_objects)

    # customer = CsvHandler.new("#{dir}customers.csv")
    # CustomerRepository.new(customer.data)

    # invoice_items = CsvHandler.new("#{dir}invoice_itmes.csv")
    # InvoiceItemsRepository.new(invoice_items.data)

    # items = CsvHandler.new("#{dir}items.csv")
    # ItemsRepository.new(items.data)

    # transactions = CsvHandler.new("#{dir}transactions.csv")
    # TransactionsRepository.new(transactions.data)

    # invoices = CsvHandler.new("#{dir}invoices.csv")
    # InvoicesRepository.new(invoices.data)
  end


end
