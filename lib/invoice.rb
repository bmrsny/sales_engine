class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = parent
  end

  def customer
    repository.find_customers_from(customer_id)
  end

  def merchant
    repository.find_merchants_from(merchant_id)
  end

  def invoice_items
    repository.find_invoice_items_from(id)
  end

  def items
    repository.find_items_from(id)
  end

  def transactions
    repository.find_transactions_from(id)
  end

  def charge(options = {})
    credit_card_number = options[:credit_card_number]
    credit_card_expiration = options[:credit_card_expiration]
    result = options[:result]
    repository.create_transaction(credit_card_number, credit_card_expiration, result,id)
  end
end
