require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :repository, :customers

  def setup
    @customers = [
      {id: "1", first_name: 'Joey', last_name: 'Ondricka', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'},
      {id: "808", first_name: 'Lon', last_name: 'Johns', created_at: '2012-03-27 14:54:43 UTC', updated_at: '2012-03-27 14:57:28 UTC'},
      {id: "141", first_name: 'Oma', last_name: 'Johns', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:43 UTC'}
    ].map { |row| Customer.new(row) }

    @repository = CustomerRepository.new(customers)
  end

  def test_can_retrieve_by_id
    repository
    customers = repository.find_by_id(808)
    assert_equal 1, customers.length
  end

  def test_can_retrieve_by_first_name
    repository
    customers = repository.find_by_first_name('Joey')
    assert_equal 1, customers.length
  end

  def test_can_retrieve_by_last_name
    repository
    customers = repository.find_by_last_name('Ondricka')
    assert_equal 1, customers.length
  end
end
