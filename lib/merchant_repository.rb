require_relative 'merchant'
class MerchantRepository
  attr_reader :merchant

  def initialize(merchants)
    @merchants = merchants
  end

  def find_by_id(x)
    merchants.select do |merchant|
      merchant.id == x
    end
  end

  def find_by_name(x)
    if merchant.name != x
      []
    else
      merchants.select do |merchant|
        merchant.name == x
      end
    end
  end
end
