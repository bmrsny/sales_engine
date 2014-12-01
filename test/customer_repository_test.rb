require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :repository,
              :customers,
              :sales_engine

  def setup
    @sales_engine = Minitest::Mock.new
    @repository   = CustomerRepository.new("./data/fixtures/customers.csv", sales_engine)
  end

  def test_can_retrieve_by_id
    customer = repository.find_by_id(2)
    assert_equal "Cecelia", customer.first_name
  end

  def test_can_retrieve_by_first_name
    customer = repository.find_by_first_name('Joey')
    assert_equal 1, customer.id
  end

  def test_can_retrieve_by_last_name
    customer = repository.find_by_last_name('Ondricka')
    assert_equal 1, customer.id
  end

  def test_can_find_a_random_customer
    customer = repository.random
    assert_instance_of(Customer, customer)
  end

  def test_can_find_all_customers
    customer = repository.all
    assert_equal 24, customer.count
  end

    def test_can_find_all_customers_by_first_name
      customer = repository.find_all_by_first_name('Joey')
      assert 1, customer.count
  end

  def test_can_find_by_updated_at
    customer = repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, customer.id
  end

  def test_can_find_by_created_at
    customer = repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, customer.id
  end

  def test_can_find_all_by_updated_at
    customer = repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, customer.count
  end

  def test_can_find_all_by_created_at
    customer = repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, customer.count
  end

  def test_delegates_invoices_to_the_sales_engine
    sales_engine.expect(:find_invoices_from_customer_id, nil, [1])
    repository.find_invoices_from(1)
    sales_engine.verify
  end
end
