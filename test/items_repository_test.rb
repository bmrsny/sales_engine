require_relative 'test_helper'
require_relative '../lib/items_repository'

class ItemsRepositoryTest < Minitest::Test
  attr_reader :repository,
              :sales_engine

  def setup
    @sales_engine = Minitest::Mock.new
    @repository   = ItemsRepository.new('./data/fixtures/items.csv', sales_engine)
  end

  def test_can_retrieve_id
    items = repository.find_by_id(2)
    assert_equal 2, items.id
  end

  def test_can_retrieve_by_name
    items = repository.find_by_name("Item Autem Minima")
    assert_equal 2, items.id
  end

  def test_can_find_by_merchant_id
    items = repository.find_by_id(4)
    assert_equal "Item Nemo Facere", items.name
  end

  def test_can_find_by_name
    items = repository.find_by_name("Item Autem Minima")
    assert_equal 2, items.id
  end

  def test_can_find_by_unit_price
    items = repository.find_by_unit_price(75107)
    assert_equal 1, items.id
  end

  def test_can_find_by_merchant_id
    items = repository.find_by_merchant_id(1)
    assert_equal 1, items.id
  end

  def test_can_find_by_created_at
    items = repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, items.id
  end

  def test_can_find_by_updated_at
    items = repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, items.id
  end

  def test_can_find_all_by_id
    items = repository.find_all_by_id(1 )
    assert_equal 1, items.count
  end

  def test_can_find_all_by_name
    items = repository.find_all_by_name("Item Autem Minima")
    assert_equal 1, items.count
  end

  def test_can_find_all_by_unit_price
    items = repository.find_all_by_unit_price(75107)
    assert_equal 1, items.count
  end

  def test_can_find_all_by_created_at
    items = repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 24, items.count
  end

  def test_can_find_all_by_updated_at
    items = repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 24, items.count
  end

  def test_can_find_all_items
    items = repository.all
    assert items
  end

  def test_can_find_a_random_item
    items = repository.random
    assert_instance_of Items, items
  end

  def test_can_find_all_by_merchant_id
    items = repository.find_all_by_merchant_id(1)
    assert_equal 15, items.count
  end
end
