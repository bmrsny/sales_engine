require_relative 'merchant'
require 'csv'
class MerchantRepository
  attr_reader :merchants,
              :sales_engine

  def initialize(merchants, sales_engine)
    @merchants    = merchants
    @sales_engine = sales_engine
  end

  def self.build_merchants(filename='./data/merchants.csv')
    data = CSV.open(filename, headers: true, header_converters: :symbol)
    rows = data.map { |row| Merchant.new(row, sales_engine) }
    new(rows)
  end

  def find_by_id(x)
    merchants.select do |merchant|
      merchant.id == x
    end
  end

  def find_by_name(x)
    merchants.select do |merchant|
      merchant.name == x
    end
  end

  def find_items_from(id)
    sales_engine.find_items_from_merchant(id)
  end
end
