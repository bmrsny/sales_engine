require_relative 'invoice_item'
require_relative 'csv_handler'
require 'date'

class InvoiceItemRepository
  attr_reader   :sales_engine,
                :data
  attr_accessor :repository
  def initialize(file_name, parent)
    @data = CSVHandler.load_data(file_name)
    @repository = repository.class == Array ? repository : load_invoice_items
    @sales_engine = parent
  end


  def load_invoice_items
    repository = data.map do |row|
      InvoiceItem.new(row, self)
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

  def find_invoice_items_from_invoice(invoice_id)
    sales_engine.invoice_find_invoice_items_by_id(invoice_id)
  end

  def find_invoice_items_from_item(item_id)
    sales_engine.(item_id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def add(new_invoice, items)
    grouped_items = group_items(items)

    # grouped_items = items.group_by {|item| item.id }
    grouped_items.map {|item|create_invoice_item(new_invoice, item) }
  end

  def group_items(items)
    grouped = Hash.new(0)
    items.each {|item| grouped[item] += 1 }
    grouped
  end

  def create_invoice_item(new_invoice, grouped_item)
    new_invoice_item = {
      :id =>         next_id,
      :item_id =>    grouped_item.first.id,
      :invoice_id => new_invoice.id,
      :unit_price => grouped_item.first.unit_price,
      :quantity =>   grouped_item.last,
      :created_at => Date.today.to_s,
      :updated_at => Date.today.to_s
    }
    @repository << InvoiceItem.new(new_invoice_item, self)
    repository.last
  end

  def next_id
    repository.max_by { |invoice_item| invoice_item.id  }.id + 1
  end
end
