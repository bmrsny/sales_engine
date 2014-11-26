require_relative 'merchant'
require 'csv'
class MerchantRepository
  attr_reader :merchants
              #:sales_engine

  def initialize(merchants)
    @merchants = merchants
  end

  def self.build_merchants(filename='./data/merchants.csv')
    data = CSV.open(filename, headers: true, header_converters: :symbol)
    rows = data.map { |row| Merchant.new(row) }
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
    puts 'Whoo in the repos'
    #sales_engine.find_items_from_merchant_id(id)????
  end
end
