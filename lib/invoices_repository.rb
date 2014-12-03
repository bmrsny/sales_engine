require_relative 'invoices'
require_relative 'csv_handler'
require 'date'
class InvoicesRepository
  attr_reader :sales_engine,
              :data

  attr_accessor :invoices

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @invoices     = invoices.class == Array ? invoices : load_invoices
    @sales_engine = parent
  end

  def load_invoices
    invoices = data.map do |row|
      Invoices.new(row, self)
    end
  end

  def find_by_id(x)
    invoices.find do |invoice|
      invoice.id == x
    end
  end

  def find_by_customer_id(x)
    invoices.find do |invoice|
      invoice.customer_id == x
    end
  end

  def find_by_merchant_id(x)
    invoices.find do |invoice|
      invoice.merchant_id == x
    end
  end

  def find_by_status(x)
    invoices.find do |invoice|
      invoice.status == x
    end
  end

  def find_by_created_at(created_at)
    invoices.find {|invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    invoices.find {|invoice| invoice.updated_at == updated_at}
  end

  def find_all_by_id(x)
    invoices.select do |invoice|
      invoice.id == x
    end
  end

  def find_all_by_customer_id(x)
    invoices.select do |invoice|
      invoice.customer_id == x
    end
  end

  def find_all_by_merchant_id(x)
    invoices.select do |invoice|
      invoice.merchant_id == x
    end
  end

  def find_all_by_status(x)
    invoices.select do |invoice|
      invoice.status == x
    end
  end

  def find_all_by_created_at(created_at)
    invoices.select {|invoice| invoice.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    invoices.select {|invoice| invoice.updated_at == updated_at}
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_customers_from(id)
    sales_engine.invoice_find_customer_by_id(id)
  end

  def find_merchants_from(id)
    sales_engine.invoice_find_merchant_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def find_invoices_from(id)
    sales_engine.invoice_find_invoice_items_by_id(id)
  end

  def find_items_from(invoice_id)
    sales_engine.invoice_find_items_by_id(invoice_id)
  end

  def find_transactions_from(id)
    sales_engine.invoices_find_transactions_by_id(id)
  end

  def create(options = {})
    customer = options[:customer]
    merchant = options[:merchant]
    status   = options[:status]
    items    = options[:items]
    sales_engine.create_invoice(customer,merchant,status,items)
  end

  def add(customer, merchant, status)
    new_invoice = {
      :id =>           next_id,
      :customer_id =>  customer.id,
      :merchant_id =>  merchant.id,
      :status =>       status,
      :created_at =>  Date.today.to_s,
      :updated_at =>  Date.today.to_s
    }

    invoices << Invoices.new(new_invoice, self)
    invoices.last
  end

  def next_id
    invoices.max_by { |invoice| invoice.id  }.id + 1
  end

  def create_transaction(credit_card_number, credit_card_expiration, result, id)
    sales_engine.create_transaction(credit_card_number, credit_card_expiration, result, id)
  end
end
