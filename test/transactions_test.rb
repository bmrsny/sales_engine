require_relative 'test_helper'
require_relative '../lib/transactions'

class TransactionTest < Minitest::Test
  attr_reader :transaction,
              :parent

  def setup
    data = {
      id: '9',
      invoice_id: '10',
      credit_card_number: '4140149827486249',
      credit_card_expiration_date: '',
      result: 'success',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
    }
    @parent     = Minitest::Mock.new
    @transaction = Transactions.new(data, parent)
  end

  def test_it_exists
    assert Transactions
  end

  def test_transactions_has_attributes
    assert_equal 9, transaction.id
    assert_equal 10, transaction.invoice_id
    assert_equal '4140149827486249', transaction.credit_card_number
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:53:59 UTC', transaction.created_at
    assert_equal '2012-03-27 14:54:10 UTC', transaction.updated_at
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_transactions_from, nil, [10])
    transaction.invoice
    parent.verify
  end
end
