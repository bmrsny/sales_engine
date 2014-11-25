require_relative 'invoices'

class InvoicesRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def find_by_id(x)
    invoices.select do |invoice|
      invoice.id == x
    end
  end

  def find_by_customer_id(x)
    invoices.select do |invoice|
      invoice.customer_id == x
    end
  end

  def find_by_merchant_id(x)
    invoices.select do |invoice|
      invoice.merchant_id == x
    end
  end

  def find_by_status(x)
    invoices.select do |invoice|
      invoice.status == x
    end
  end

  # def find_all_by_id(x)
  #   invoices.select do |invoice|
  #     invoice.all_by_id == x
  #   end
  # end
  #
  # def find_all_by_customer_id(x)
  #   invoices.select do |invoice|
  #     invoice.all_by_item_id == x
  #   end
  # end
  #
  # def find_all_by_merchant_id(x)
  #   invoices.select do |invoice|
  #     invoice.all_by_invoice_id == x
  #   end
  # end
  #
  # def find_all_by_status(x)
  #   invoices.select do |invoice|
  #     invoice.all_by_quantity == x
  #   end
  # end

end
