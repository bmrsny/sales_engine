require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test


  class MerchantRepositoryFinders < MerchantRepositoryTest
    attr_reader :repository,
                :merchants,
                :sales_engine

    def setup
      @sales_engine = Minitest::Mock.new
      @merchants    = MerchantRepository.new('./data/fixtures/merchants.csv', sales_engine)
    end

    def test_can_retrieve_by_id
      merchant = merchants.find_by_id(1)
      assert_equal "Schroeder-Jerde", merchant.name
    end

    def test_can_find_all_by_id
      merchant = merchants.find_all_by_id(3)
      assert_equal 1, merchant.count
    end

    def test_can_retrieve_by_name
      merchant = merchants.find_by_name("Williamson Group")
      assert_equal 5, merchant.id
    end

    def test_can_retrieve_all_name
      merchant = merchants.find_all_by_name("Williamson Group")
      assert_equal 5, merchant.first.id
      assert_equal 6, merchant.last.id
    end

    def test_it_can_find_random_merchant
      merchant = merchants.random
      assert_instance_of(Merchant, merchant)
    end

    def test_can_find_all
      merchant = merchants.all
      assert 24, merchant.count
    end

    def test_can_find_by_updated_at
      merchant = merchants.find_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal 1, merchant.id
    end

    def test_can_find_all_by_updated_at
      merchant = merchants.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal 8, merchant.count
    end

    def test_can_find_by_created_at
      merchant = merchants.find_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal 1, merchant.id
    end

    def test_can_find_all_by_created_at
      merchant = merchants.find_all_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal 9, merchant.count
    end

    def test_can_find_a_random_customer
      merchant = merchants.random
      assert_instance_of(Merchant, merchant)
    end

    def test_it_has_a_sales_engine
      assert merchants.sales_engine
    end

    def test_the_repository_is_not_empty
      refute merchants.merchants.empty?
    end

    def test_it_delegates_items_to_the_sales_engine
      sales_engine.expect(:find_items_from_merchant, nil, [1])
      merchants.find_items_from(1)
      sales_engine.verify
    end
  end
end
