require_relative 'test_helper'
require_relative '../lib/invoices_repository'

class InvoicesRepositoryTest < Minitest::Test
  attr_reader :invoices,
              :repository,
              :sales_engine

  def setup
    @sales_engine = Minitest::Mock.new
    @repository   = InvoicesRepository.new('./data/fixtures/invoices.csv', sales_engine)
  end

  def test_can_retrieve_attribute_id
    invoices = repository.find_by_id(8)
    assert_equal 1, invoices.customer_id
  end

  def test_can_retrieve_attribute_customer_id
    invoices = repository.find_by_customer_id(3)
    assert_equal 10, invoices.id
  end

  def test_can_retrieve_attribute_merchant_id
    invoices = repository.find_by_merchant_id(27)
    assert_equal 9, invoices.id
  end

  def test_can_retrieve_attribute_status
    invoices = repository.find_by_status("shipped")
    assert_equal 1, invoices.id
  end

  def test_can_find_by_created_at
    invoices = repository.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, invoices.id
  end

  def test_can_find_by_updated_at
    invoices = repository.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, invoices.id
  end

  def test_can_find_all_invoices
    invoices = repository.all
    assert_equal 24, invoices.count
  end

  def test_can_find_a_random_invoice
    invoices = repository.random
    assert_instance_of(Invoices, invoices)
  end

  def test_can_find_all_by_id
    invoices = repository.find_all_by_id(4)
    assert_equal 1, invoices.count
  end

  def test_it_returns_an_empty_array_when_no_match
    invoices = repository.find_all_by_id(29)
    assert_equal [], invoices
  end

  def test_can_find_all_customers_by_id
    invoices = repository.find_all_by_customer_id(3)
    assert_equal 4, invoices.count
  end

  def test_can_find_all_merchants_by_id
    invoices = repository.find_all_by_merchant_id(26)
    assert_equal 1, invoices.count
  end

  def test_can_find_all_by_status
    invoices = repository.find_all_by_status("shipped")
    assert_equal 24, invoices.count
  end

  def test_can_find_all_by_created_at
    invoices = repository.find_all_by_created_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, invoices.count
  end

  def test_can_find_all_by_updated_at
    invoices = repository.find_all_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, invoices.count
  end

  def find_customers_from(id)
    sales_engine.find_customers_from_invoice_id(id)
  end
end
