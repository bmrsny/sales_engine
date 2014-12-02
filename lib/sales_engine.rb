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

  def find_invoices_from_customer_id(id)
    invoices_repository.find_all_by_customer_id(id)
  end

  def invoice_find_merchant_by_id(id)
    merchant_repository.find_all_by_id(id)
  end

  def invoice_find_customer_by_id(id)
    customer_repository.find_by_id(id)
  end

  def invoice_find_invoice_items_by_id(invoice_id)
    invoice_items_repository.find_all_by_invoice_id(invoice_id)
  end

  def invoice_items_find_items_by_id(item_id)
    items_repository.find_by_id(item_id)
  end

  def invoice_find_items_by_id(invoice_id)
    invoice_items = invoice_find_invoice_items_by_id(invoice_id)
    invoice_items.map {|invoice_item| invoice_items_find_items_by_id(invoice_item.item_id)}
  end
end
