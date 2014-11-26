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
  attr_accessor :dir, :merchant_repository, :customer_repository,
                :items_repository, :invoice_items_repository,
                :transactions_repository, :invoices_repository

  def initialize(dir="./data/")
    @dir = dir
    startup
  end

  def startup

    @merchant_repository ||= MerchantRepository.build_merchants("#{dir}merchants.csv")

    @customer_repository ||= CustomerRepository.build_customers("#{dir}customers.csv")

    @invoice_items_repository ||= InvoiceItemsRepository.build_invoice_items("#{dir}invoice_items.csv")

    @items ||= ItemsRepositor.build_items("#{dir}items.csv")

    @transactions ||= Transactions.build_transactions("#{dir}transactions.csv")

    @invoices ||= Invoices.build_invoices("#{dir}invoices.csv")
  end
end
