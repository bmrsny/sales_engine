require 'date'
class Customer
  attr_reader :id, :first_name,
              :last_name, :created_at,
              :updated_at, :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def invoices
    repository.find_invoice_from(id)
  end

  def transactions
    repository.find_transactions(id)
  end

  def favorite_merchant
    repository.find_favorite_merchant(id)
    #successful_transactions.map {|transaction|}
  end

  # def successful_transactions
  #   transactions.select {|transaction| transaction.result == "success"}
  # end
end
