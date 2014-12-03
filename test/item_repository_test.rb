require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  class ItemRepositoryFinders < ItemRepositoryTest
  attr_reader :repository,
              :item,
              :sales_engine

    def setup
      @sales_engine = Minitest::Mock.new
      @repository   = ItemRepository.new('./data/fixtures/items.csv', sales_engine)
    end

    def test_can_retrieve_id
      item = repository.find_by_id(2)
      assert_equal 2, item.id
    end

    def test_can_retrieve_by_name
      item = repository.find_by_name("Item Autem Minima")
      assert_equal 2, item.id
    end

    def test_can_find_by_merchant_id
      item = repository.find_by_id(4)
      assert_equal "Item Nemo Facere", item.name
    end

    def test_can_find_by_name
      item = repository.find_by_name("Item Autem Minima")
      assert_equal 2, item.id
    end

    def test_can_find_by_unit_price
      item = repository.find_by_unit_price(75107)
      assert_equal 1, item.id
    end

    def test_can_find_by_merchant_id
      item = repository.find_by_merchant_id(1)
      assert_equal 1, item.id
    end

    def test_can_find_by_created_at
      item = repository.find_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal 1, item.id
    end

    def test_can_find_by_updated_at
      item = repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal 1, item.id
    end

    def test_can_find_all_by_id
      item = repository.find_all_by_id(1 )
      assert_equal 2, item.count
    end

    def test_can_find_all_by_name
      item = repository.find_all_by_name("Item Autem Minima")
      assert_equal 1, item.count
    end

    def test_can_find_all_by_unit_price
      item = repository.find_all_by_unit_price(75107)
      assert_equal 1, item.count
    end

    def test_can_find_all_by_created_at
      item = repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal 24, item.count
    end

    def test_can_find_all_by_updated_at
      item = repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal 24, item.count
    end

    def test_can_find_all_items
      item = repository.all
      assert item
    end

    def test_can_find_a_random_item
      item = repository.random
      assert_instance_of Item, item
    end

    def test_can_find_all_by_merchant_id
      item = repository.find_all_by_merchant_id(1)
      assert_equal 15, item.count
    end

    def test_it_delegates_merchants_to_sales_engine
      sales_engine.expect(:items_find_merchant_by_merchant_id, nil, [1])
      repository.find_merchants_from(1)
      sales_engine.verify
    end

    def test_it_delegates_items_to_sales_engine
      sales_engine.expect(:items_find_invoice_items_from_items_id, nil, [1])
      repository.find_invoice_items_from(1)
      sales_engine.verify
    end
  end
end
