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
end
