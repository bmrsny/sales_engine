require 'csv'                                # => true
require_relative 'merchant'                  # => true
# require_relative 'merchant_repository'       # => true
require './lib/merchant_repository'
require_relative 'customer'                  # => true
require_relative 'customer_repository'       # => true
require_relative 'invoice_items'             # => true
require_relative 'invoice_items_repository'  # => true
require_relative 'invoices'                  # => true
require_relative 'invoices_repository'       # => true
require_relative 'items'                     # => true
require_relative 'items_repository'          # => true
require_relative 'transactions'              # => true
require_relative 'transactions_repository'   # => true

class SalesEngine
  attr_reader :dir, :merchant_repository, :customer_repository,  # => :customer_repository
                :items_repository, :invoice_items_repository,    # => :invoice_items_repository
                :transactions_repository, :invoices_repository   # => nil

  def initialize(dir="./data/")
    @dir = dir
    startup
  end

  def startup
    @merchant_repository   ||= MerchantRepository.new(dir + '/merchants.csv', self)

    @customer_repository ||= CustomerRepository.new(dir + "customers.csv", self)

    @invoice_items_repository ||= InvoiceItemsRepository.new(dir + "invoice_items.csv", self)

    @items_repository ||= ItemsRepository.new(dir + "items.csv", self)

    @transactions_repository ||= TransactionsRepository.new(dir + "transactions.csv", self)

    @invoices_repository ||= InvoicesRepository.new(dir + "invoices.csv", self)
  end

  def find_items_from_merchant(id)
    items_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_from_merchant_id(id)
    invoices_repository.find_all_by_merchant_id(id)
  end

  def find_customers_from_invoice_id(id)
    customer_repository.find_all_by_customer_id(id)
  end
end
