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
    repository.find_invoices_from(id)
  end

  def transaction
    repository.find_transactions(id)
  end
end
