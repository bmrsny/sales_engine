require_relative 'invoices'
require_relative 'csv_handler'
class InvoicesRepository
  attr_reader :invoices,
              :sales_engine,
              :data

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
    sales_engine.find_customers_from_invoice_id(id)
  end
end
