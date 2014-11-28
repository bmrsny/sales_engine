require 'csv'                                # => true
require_relative 'merchant'                  # => true
require_relative 'merchant_repository'       # => true
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
    # @customer_repository
    # @invoices_repository
    # @invoice_items_repository
    # @items_repository
    # @merchant_repository
    # @transactions_repository
    startup
  end

  def startup

    @merchant_repository ||= MerchantRepository.new(self)

    @customer_repository ||= CustomerRepository.build_customers("#{dir}customers.csv")

    #@invoice_items_repository ||= InvoiceItemsRepository.build_invoice_items("#{dir}invoice_items.csv")

    #@items ||= ItemsRepositor.build_items("#{dir}items.csv")

    #@transactions ||= Transactions.build_transactions("#{dir}transactions.csv")

    #@invoices ||= Invoices.build_invoices("#{dir}invoices.csv")
  end

  # def find_items_from_merchant(id)
  #
  # end
end
