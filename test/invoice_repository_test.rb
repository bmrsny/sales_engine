require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice,
              :repository,
              :sales_engine

  def setup
    @sales_engine = Minitest::Mock.new
    @repository   = InvoiceRepository.new('./data/fixtures/invoices.csv', sales_engine)
  end

  def test_can_retrieve_attribute_id
    invoice = repository.find_by_id(8)
    assert_equal 1, invoice.customer_id
  end

  def test_can_retrieve_attribute_customer_id
    invoice = repository.find_by_customer_id(3)
    assert_equal 10, invoice.id
  end

  def test_can_retrieve_attribute_merchant_id
    invoice = repository.find_by_merchant_id(27)
    assert_equal 9, invoice.id
  end

  def test_can_retrieve_attribute_status
    invoice = repository.find_by_status("shipped")
    assert_equal 1, invoice.id
  end

  def test_can_find_by_created_at
    invoice = repository.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, invoice.id
  end

  def test_can_find_by_updated_at
    invoice = repository.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, invoice.id
  end

  def test_can_find_all_invoice
    invoice = repository.all
    assert_equal 24, invoice.count
  end

  def test_can_find_a_random_invoice
    invoice = repository.random
    assert_instance_of(Invoice, invoice)
  end

  def test_can_find_all_by_id
    invoice = repository.find_all_by_id(4)
    assert_equal 1, invoice.count
  end

  def test_it_returns_an_empty_array_when_no_match
    invoice = repository.find_all_by_id(29)
    assert_equal [], invoice
  end

  def test_can_find_all_customers_by_id
    invoice = repository.find_all_by_customer_id(3)
    assert_equal 4, invoice.count
  end

  def test_can_find_all_merchants_by_id
    invoice = repository.find_all_by_merchant_id(26)
    assert_equal 1, invoice.count
  end

  def test_can_find_all_by_status
    invoice = repository.find_all_by_status("shipped")
    assert_equal 24, invoice.count
  end

  def test_can_find_all_by_created_at
    invoice = repository.find_all_by_created_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, invoice.count
  end

  def test_can_find_all_by_updated_at
    invoice = repository.find_all_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, invoice.count
  end

  def find_customers_from(id)
    sales_engine.find_customers_from_invoice_id(id)
  end

  def test_delegates_customers_to_sales_engine
    sales_engine.expect(:invoice_find_customer_by_id, nil, [1])
    repository.find_customers_from(1)
    sales_engine.verify
  end

  def test_delegates_merchants_to_sales_engine
    sales_engine.expect(:invoice_find_merchant_by_id, nil, [1])
    repository.find_merchants_from(1)
    sales_engine.verify
  end

  def test_delegates_invoice_items_to_sales_engine
    sales_engine.expect(:invoice_find_invoice_items_by_id, nil, [1])
    repository.find_invoice_from(1)
    sales_engine.verify
  end

  def test_delegates_items_to_sales_engine
    sales_engine.expect(:invoice_find_items_by_id, nil, [1])
    repository.find_items_from(1)
    sales_engine.verify
  end

  def test_delegates_transactions_to_sales_engine
    sales_engine.expect(:invoice_find_transactions_by_id, nil, [1])
    repository.find_transactions_from(1)
    sales_engine.verify
  end
end
