require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :dir, :merchant_repository, :customer_repository,
                :item_repository, :invoice_item_repository,
                :transaction_repository, :invoice_repository

  def initialize(dir = "./data")
    @dir = dir
    startup
  end

  def startup
    @merchant_repository   ||= MerchantRepository.new(dir + '/merchants.csv', self)

    @customer_repository ||= CustomerRepository.new(dir + "/customers.csv", self)

    @invoice_item_repository ||= InvoiceItemRepository.new(dir + "/invoice_items.csv", self)

    @item_repository ||= ItemRepository.new(dir + "/items.csv", self)

    @transaction_repository ||= TransactionRepository.new(dir + "/transactions.csv", self)

    @invoice_repository = InvoiceRepository.new(dir + "/invoices.csv", self)
  end

  def find_transaction_from_invoice_id(id) ### rename this very confusing
    invoice_repository.find_by_id(id)
  end

  def find_items_from_merchant(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoice_from_merchant(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_invoice_from_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def invoice_find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def invoice_find_customer_by_id(id)
    customer_repository.find_by_id(id)
  end

  def invoice_find_invoice_items_by_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def invoice_items_find_items_by_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def invoice_item_find_invoice_by_id(invoice_id)
    invoice_repository.find_all_by_id(invoice_id)
  end

  def invoice_item_find_items_by_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def invoice_find_items_by_id(invoice_id)
    invoice_items = invoice_find_invoice_items_by_id(invoice_id)
    invoice_items.map {|invoice_item| invoice_items_find_items_by_id(invoice_item.item_id)}
  end

  def invoice_find_transactions_by_id(id)
    transaction_repository.find_all_by_id(id)
  end

  def create_invoice(customer, merchant, status, items)
    new_invoice = invoice_repository.add(customer, merchant, status)
    invoice_item_repository.add(new_invoice, items)
    new_invoice
  end

  def create_transaction(credit_card_number, credit_card_expiration, result, id)
    transaction_repository.add(credit_card_number, credit_card_expiration, result, id)
  end

  def find_customer_transactions(id)
    invoices = invoice_repository.find_all_by_customer_id(id)
    invoices.map {|invoice| transaction_repository.find_all_by_invoice_id(invoice.id) }.flatten
  end

  def items_find_merchant_by_merchant_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def items_find_invoice_items_from_items_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_customers_favorite_merchant(id)
    transactions = find_customer_transactions(id)
    successful_transactions = transactions.select {|transaction| transaction.result == "success"}
    merchants = successful_transactions.map {|transaction| find_merchant_from_transaction(transaction.id)}
    merchants.max_by {|merchant| merchants.count(merchant)}
  end

  def find_merchant_from_transaction(transaction_id)
    invoice = find_transaction_from_invoice_id(transaction_id)
    invoice_find_merchant_by_id(invoice.merchant_id)
  end
end
