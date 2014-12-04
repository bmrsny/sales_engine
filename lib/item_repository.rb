require_relative 'item'
require_relative 'csv_handler'
class ItemRepository
  attr_reader :repository,
              :sales_engine,
              :data

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @repository   = repository.class == Array ? items : load_items
    @sales_engine = parent
  end

  def load_items
    repository = data.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_id(x)
    repository.find do |item|
      item.id == x
    end
  end

  def find_by_name(x)
    repository.find do |item|
      item.name == x
    end
  end

  def find_by_merchant_id(x)
    repository.find do |item|
      item.merchant_id == x
    end
  end

  def find_by_unit_price(price)
    repository.find { |item| item.unit_price == price}
  end

  def find_by_created_at(created_at)
    repository.find { |item| item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    repository.find { |item| item.updated_at == updated_at }
  end

  def find_all_by_id(id)
    repository.select { |item| item.id == id }
  end

  def find_all_by_name(name)
    repository.select {|item| item.name == name}
  end

  def find_all_by_created_at(created_at)
    repository.select { |item| item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    repository.select { |item| item.updated_at == updated_at}
  end

  def find_all_by_unit_price(price)
    repository.select { |item| item.unit_price == price }
  end

  def find_all_by_merchant_id(id)
    repository.select {|item| item.merchant_id == id}
  end

  def all
    repository
  end

  def random
    repository.sample
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def find_merchants_from(merchant_id)
    sales_engine.items_find_merchant_by_merchant_id(merchant_id)
  end

  def find_invoice_items_from(id)
    sales_engine.items_find_invoice_items_from_items_id(id)
  end

end
