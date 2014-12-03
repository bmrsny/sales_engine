require_relative 'merchant'
require_relative 'csv_handler'
class MerchantRepository
  attr_reader :merchants,
              :sales_engine,
              :data

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @merchants    = merchants.class == Array ? merchants : load_merch
    @sales_engine = parent
  end

  def load_merch
    merchants = data.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_id(x)
    merchants.find do |merchant|
      merchant.id == x
    end
  end

  def find_all_by_id(id)
    merchants.select do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(x)
    merchants.find do |merchant|
      merchant.name == x
    end
  end

  def find_all_by_name(name)
    merchants.select do |merchant|
      merchant.name == name
    end
  end

  def find_by_updated_at(criteria)
    merchants.find do |merchant|
      merchant.updated_at == criteria
    end
  end

  def find_all_by_updated_at(criteria)
    merchants.select do |merchant|
      merchant.updated_at == criteria
    end
  end

  def find_by_created_at(criteria)
    merchants.find do |merchant|
      merchant.created_at == criteria
    end
  end

  def find_all_by_created_at(criteria)
    merchants.select do |merchant|
      merchant.created_at == criteria
    end
  end

  def random
    merchants.sample
  end

  def all
    merchants
  end

  def find_items_from(id)
    sales_engine.find_items_from_merchant(id)
  end

  def find_invoice_from(id)
    sales_engine.find_invoice_from_merchant(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
