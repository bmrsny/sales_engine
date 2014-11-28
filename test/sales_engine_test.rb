require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine, :customer_repository

  def setup
    @sales_engine = SalesEngine.new
    sales_engine.startup
  end

  def test_there_is_a_customer_repository_on_startup
    assert_equal 1001, sales_engine.customer_repository.customer.count
  end

  def test_there_is_a_merchant_repository_on_startup
    assert_equal 33, sales_engine.merchant_repository.merchant.count


  end
end
