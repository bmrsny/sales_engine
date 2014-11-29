require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine, :customer_repository

  def setup
    @sales_engine = SalesEngine.new('data/fixtures/')
    sales_engine.startup
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
end
