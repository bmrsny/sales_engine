require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :customer, :parent
  def setup
    data = {
      id: '1',
      first_name: 'Joey',
      last_name: 'Ondricka',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }
    @parent   = Minitest::Mock.new
    @customer = Customer.new(data,parent)
  end

  def test_it_exists
    assert Customer
  end

  def test_customer_has_attributes
    assert_equal 1, customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
    assert_equal '2012-03-27 14:54:09 UTC', customer.created_at
    assert_equal '2012-03-27 14:54:09 UTC', customer.updated_at
  end

  def test_it_delegates_invoice_to_its_repository
    parent.expect(:find_invoice_from, nil, [1])
    customer.invoice
    parent.verify
  end

  def test_delegates_transactions_to_repository
    parent.expect(:find_transactions, nil, [1])
    customer.transaction
    parent.verify
  end
end
