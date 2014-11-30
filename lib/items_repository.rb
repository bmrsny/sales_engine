require_relative 'items'
require_relative 'csv_handler'
class ItemsRepository
  attr_reader :items,
              :sales_engine,
              :data

  # def initialize(file_name, parent)
  #   @data         = CSVHandler.load_data(file_name)
  #   @items        = []
  #   @sales_engine = parent
  # end

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @items        = items.class == Array ? items : load_items
    @sales_engine = parent
  end

  def load_items
    items = data.map do |row|
      Items.new(row, self)
    end
  end

  def find_by_id(x)
    items.find do |item|
      item.id == x
    end
  end

  def find_by_name(x)
    items.find do |item|
      item.name == x
    end
  end

  def find_by_merchant_id(x)
    items.find do |item|
      item.merchant_id == x
    end
  end

  def find_by_unit_price(price)
    items.find { |item| item.unit_price == price}
  end

  def find_by_created_at(created_at)
    items.find { |item| item.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    items.find { |item| item.updated_at == updated_at}
  end

  def find_all_by_id(id)
    items.select { |item| item.id == id}
  end

  def find_all_by_name(name)
    items.select {|item| item.name == name}
  end

  def find_all_by_created_at(created_at)
    items.select { |item| item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    items.select { |item| item.updated_at == updated_at}
  end

  def find_all_by_unit_price(price)
    items.select { |item| item.unit_price == price }
  end

  def find_all_by_merchant_id(id)
    items.select {|item| item.merchant_id == id}
  end

  def all
    items
  end

  def random
    items.sample
  end
end
