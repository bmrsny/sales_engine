require 'date'
class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def items
    repository.find_items_from(id)
  end

  def invoices
    repository.find_invoice_from(id)
  end
end
