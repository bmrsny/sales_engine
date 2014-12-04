require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repository,
              :sales_engine

  def setup
    @sales_engine = Minitest::Mock.new
    @repository = InvoiceItemRepository.new('./data/fixtures/invoice_items.csv', sales_engine)
  end

  def test_can_retrieve_attribute_id
    items = repository.find_by_id(2)
    assert_equal 2, items.id
  end

  def test_can_find_a_random_invoice_item
    invoice_items = repository.random
    assert_instance_of(InvoiceItem, invoice_items)
  end

  def test_can_retrieve_attribute_item_id
    invoice_items = repository.find_by_item_id(539)
    assert_equal 1, invoice_items.id
  end

  def test_can_retrieve_attribute_invoice_id
    invoice_items = repository.find_by_invoice_id(5)
    assert_equal 5, invoice_items.invoice_id
  end

  def test_can_retrieve_attribute_quantity
    invoice_items = repository.find_by_quantity(5)
    assert_equal 1, invoice_items.id
  end

  def test_can_retrieve_attribute_unit_price
    invoice_items = repository.find_by_unit_price("76941")
    assert_equal 8, invoice_items.id
  end

  def test_it_can_retrieve_attribute_by_created_at
    invoice_items = repository.find_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, invoice_items.id
  end

  def test_it_can_retrieve_attribute_by_updated_at
    invoice_items = repository.find_by_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 1, invoice_items.id
  end

  def test_it_can_retrieve_all_attributes_by_id
    invoice_items = repository.find_all_by_id(1)
    assert_equal 1, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_item_id
    invoice_items = repository.find_all_by_item_id(539)
    assert_equal 1, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_invoice_id
    invoice_items = repository.find_all_by_invoice_id(1)
    assert_equal 8, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_quantity
    invoice_items = repository.find_all_by_quantity(5)
    assert_equal 5, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_unit_price
    invoice_items = repository.find_all_by_unit_price("76941")
    assert_equal 1, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_created_at
    invoice_items = repository.find_all_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal 15, invoice_items.count
  end

  def test_it_can_retrieve_all_attributes_by_updated_at
    invoice_items = repository.find_all_by_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal 15, invoice_items.count
  end

  def test_delegates_item_id_to_sales_engine
    sales_engine.expect(:invoice_item_find_items_by_id, nil, [535])
    repository.find_item_from(535)
    sales_engine.verify
  end

  def test_delegates_invoice_id_to_sales_engine
    sales_engine.expect(:invoice_item_find_invoice_by_id, nil, [1])
    repository.find_invoice_from(1)
    sales_engine.verify
  end
end
