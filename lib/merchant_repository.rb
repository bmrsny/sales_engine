require_relative 'merchant'
require 'csv'
class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def self.build_merchants
    data = CSV.open('./data/merchants.csv', headers: true, header_converters: :symbol)
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
end
