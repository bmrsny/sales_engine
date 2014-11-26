require_relative 'items'
class ItemsRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.build_items
    data = Csv.open('./data/items.csv' headers: true, header_converters: :symbol)
    rows = data.map { |row| Items.new(row) }
    new(rows)
  end

  def find_by_id(x)
    items.select do |item|
      item.id == x
    end
  end

  def find_by_name(x)
    items.select do |item|
      item.name == x
    end
  end

  def find_by_merchant_id(x)
    item.select do |item|
      item.merchant_id == x
    end
  end
end
