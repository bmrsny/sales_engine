require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice_items'
require_relative 'invoice_items_repository'
require_relative 'invoices'
require_relative 'invoices_repository'
require_relative 'items'
require_relative 'items_repository'
require_relative 'transactions'
require_relative 'transactions_repository'

class SalesEngine
  attr_reader :dir, :merchant_repository, :customer_repository,
                :items_repository, :invoice_items_repository,
                :transactions_repository, :invoices_repository

  def initialize(dir = "./data")
    @dir = dir
    startup
  end

  def startup
    @merchant_repository   ||= MerchantRepository.new(dir + '/merchants.csv', self)

    @customer_repository ||= CustomerRepository.new(dir + "/customers.csv", self)

    @invoice_items_repository ||= InvoiceItemsRepository.new(dir + "/invoice_items.csv", self)

    @items_repository ||= ItemsRepository.new(dir + "/items.csv", self)

    @transactions_repository ||= TransactionsRepository.new(dir + "/transactions.csv", self)

    @invoices_repository = InvoicesRepository.new(dir + "/invoices.csv", self)
  end

  def find_transactions_from_invoice_id(id)
    invoices_repository.find_all_by_transaction_id(id)
  end

  def find_items_from_merchant(id)
    merchant_repository.find_all_by_id(id)
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

  def invoices_find_transactions_by_id(id)
    transactions_repository.find_all_by_id(id)
  end

  def create_invoice(customer, merchant, status, items)
    new_invoice = invoices_repository.add(customer, merchant, status)
    invoice_items_repository.add(new_invoice, items)
    new_invoice
  end

  def create_transaction(credit_card_number, credit_card_expiration, result, id)
    transactions_repository.add(credit_card_number, credit_card_expiration, result, id)
  end

  def find_customer_transactions(id)
    invoices_repository.find_transactions_from(id)
  end

  # def items_find_merchant_by_merchant_id(merchant_id)
  #   items_repository.find_merchants_from(merchant_id)
  # end
  #
  # def items_find_invoice_items_from_items_id(id)
  #   items_repository.find_invoice_items_from(id)
  # end
end
