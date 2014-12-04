require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/invoice'

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
    sales_engine.item_repository
  end

  def test_there_is_a_invoice_item_repository_on_startup
    sales_engine.invoice_item_repository
  end

  def test_there_is_a_transactions_repository_on_startup
    sales_engine.transaction_repository
  end

  def test_there_is_a_invoice_repository_on_startup
    sales_engine.invoice_repository
  end

  def test_can_find_items_from_merchant_id
    merchant = sales_engine.merchant_repository.find_items_from(1)
    assert_equal 15, merchant.count
  end

  def test_can_find_invoice_from_merchant_id
    merchant = sales_engine.merchant_repository.find_invoice_from(10)
    assert_equal 1, merchant.count
  end

  def test_can_find_customers_from_invoice_id
    invoice = sales_engine.invoice_repository.find_by_id(10)
    assert_equal 10, invoice.id
  end

  def test_can_find_invoice_from_customer_id
    customer = sales_engine.customer_repository.find_invoice_from(7)
    assert_equal 3, customer.count
  end

  def test_can_find_merchants_from_invoice_id
    invoice = sales_engine.invoice_repository.find_merchants_from(10)
    assert_instance_of Merchant, invoice
  end

  def test_can_find_invoice_items_from_invoice_id
    invoice = sales_engine.invoice_item_repository.find_by_id(10)
    assert_equal 10, invoice.id
  end

  def test_can_find_an_item_from_invoice_id
    invoice = sales_engine.invoice_repository.find_by_id(3)
    assert_equal 8, invoice.items.count
    assert_instance_of Item, invoice.items.first
  end


  def test_can_create_new_invoice_object
    customer = sales_engine.customer_repository.find_by_id(3)
    merchant = sales_engine.merchant_repository.find_by_id(1)
    status   = ""
    items    = (1..3).map {sales_engine.item_repository.random }
    starting_length = sales_engine.invoice_repository.invoices.count
    invoice  = sales_engine.invoice_repository.create(customer: customer, merchant: merchant, status: status, items: items)
    assert_equal (starting_length + 1), sales_engine.invoice_repository.invoices.count
    assert_instance_of Invoice, invoice
  end

  def test_can_create_a_transaction
    credit_card_number     = '4444333322221111'
    credit_card_expiration = "10/13"
    result                 = "success"
    starting_length = sales_engine.transaction_repository.repository.count
    invoice = sales_engine.invoice_repository.find_by_id(18)
    charged = invoice.charge(credit_card_number: credit_card_number,
    credit_card_expiration: credit_card_expiration, result: result)
    assert_equal (starting_length + 1), sales_engine.transaction_repository.repository.count
    assert_instance_of Transaction, charged
  end

  def test_can_find_transactions_from_invoice_id
    trans = sales_engine.transaction_repository.find_all_by_invoice_id(12)
    assert_equal 3, trans.count
    # assert_instance_of Transactions, trans.invoice.first
    #this test is from invoice to transactions repo not for transactions!!!
  end

  def test_can_find_items_from_merchant_id
    merchant = sales_engine.merchant_repository.find_all_by_id(24)
    assert_equal 1, merchant.count
  end

  # def test_can_find_items_from_items_id
  #   items = sales_engine.items_repository.find_invoice_items_from(1)
  #   assert_equal 2, items.count
  # end

  def test_can_find_transactions_from_customer_id
    customer = sales_engine.customer_repository.find_by_id(1)
    assert_equal 4, customer.transactions.count
  end

  def test_can_find_favorite_merchant_from_transactions
    customer = sales_engine.customer_repository.find_by_id(13)
    assert_instance_of Merchant, customer.favorite_merchant
  end
end
