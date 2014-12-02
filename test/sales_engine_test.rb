require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/items'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new('./data/fixtures/')
    sales_engine
  end

  def test_there_is_an_instance_of_sales_engine
    assert sales_engine
  end

  def test_there_is_a_customer_repository_on_startup
     sales_engine.merchant_repository
  end

  def test_there_is_a_merchant_repository_on_startup
    sales_engine.customer_repository
  end

  def test_there_is_a_items_repository_on_startup
    sales_engine.items_repository
  end

  def test_there_is_a_invoice_items_repository_on_startup
    sales_engine.invoice_items_repository
  end

  def test_there_is_a_transactions_repository_on_startup
    sales_engine.transactions_repository
  end

  def test_there_is_a_invoices_repository_on_startup
    sales_engine.invoices_repository
  end

  def test_can_find_items_from_merchant_id
    merchant = sales_engine.merchant_repository.find_items_from(1)
    assert_equal 15, merchant.count
  end

  def test_can_find_invoices_from_merchant_id
    merchant = sales_engine.merchant_repository.find_invoices_from(26)
    assert_equal 1, merchant.count
  end

  def test_can_find_customers_from_invoice_id
    invoice = sales_engine.invoices_repository.find_by_id(10)
    assert_equal 10, invoice.id
  end

  def test_can_find_invoices_from_customer_id
    customer = sales_engine.customer_repository.find_invoices_from(7)
    assert_equal 3, customer.count
  end

  def test_can_find_merchants_from_invoice_id
    invoice = sales_engine.invoices_repository.find_merchants_from(10)
    assert_equal 1, invoice.count
  end

  def test_can_find_invoice_items_from_invoices_id
    invoice = sales_engine.invoice_items_repository.find_by_id(10)
    assert_equal 10, invoice.id
  end

  def test_can_find_an_item_from_invoice_id
    invoice = sales_engine.invoices_repository.find_by_id(3)
    assert_equal 8, invoice.items.count
    assert_instance_of Items, invoice.items.first
  end
end
