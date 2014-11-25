require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :repository, :merchants

  def setup
    @merchants = [
      {id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" },
      {id: "5", name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"},
      {id: "6", name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 16:12:25 UTC"}
    ].map { |row| Merchant.new(row) }

    @repository = MerchantRepository.new(merchants)
  end

  def test_can_retrieve_by_id
    repository
    merchants = repository.find_by_id(1)
    assert_equal 1, merchants.length  
  end

  def test_can_retrieve_by_name
    repository
    merchants = repository.find_by_name("Williamson Group")
    assert_equal 2, merchants.length
  end
end
