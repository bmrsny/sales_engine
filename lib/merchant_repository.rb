require_relative 'merchant'
class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants.map { |data| Merchant.new(data) }
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
