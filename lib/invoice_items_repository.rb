require_relative 'invoice_items'
require_relative 'csv_handler'

class InvoiceItemsRepository
  attr_reader :repository,
              :sales_engine,
              :data

  def initialize(file_name, parent)
    @data = CSVHandler.load_data(file_name)
    @repository = load_invoice_items
    @sales_engine = parent
  end


  def load_invoice_items
    data.map do |row|
      InvoiceItems.new(row, self)
    end
  end

  def all
    repository
  end

  def random
    repository.sample
  end

  def count
    repository.count
  end

  def find_by_id(id)
    repository.find { |object| id == object.id }
  end

  def find_by_item_id(item_id)
    repository.find { |object| item_id == object.item_id }
  end

  def find_by_invoice_id(invoice_id)
    repository.find { |object| invoice_id == object.invoice_id }
  end

  def find_by_quantity(quantity)
    repository.find { |object| quantity == object.quantity }

  end

  def find_by_unit_price(unit_price)
    repository.find { |object|  unit_price == object.unit_price }
  end

  def find_by_created_at(created_at)
    repository.find { |object| created_at == object.created_at }
  end

  def find_by_updated_at(updated_at)
    repository.find { |object| updated_at == object.updated_at }
  end

  def find_all_by_id(criteria)
    repository.find_all { |object| criteria == object.id }
  end

  def find_all_by_item_id(criteria)
    repository.find_all { |object| criteria == object.item_id }
  end

  def find_all_by_invoice_id(criteria)
    repository.find_all { |object| criteria == object.invoice_id }
  end

  def find_all_by_quantity(criteria)
    repository.find_all { |object| criteria == object.quantity }
  end

  def find_all_by_unit_price(criteria)
    repository.find_all { |object| criteria == object.unit_price }
  end

  def find_all_by_created_at(criteria)
    repository.find_all { |object| criteria == object.created_at }
  end

  def find_all_by_updated_at(criteria)
    repository.find_all { |object| criteria == object.updated_at }
  end
end
