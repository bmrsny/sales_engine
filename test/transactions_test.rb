require_relative 'test_helper'
require_relative '../lib/transactions'

class TransactionTest < Minitest::Test
  def test_transaction_has_attributes
    data = {
      id: '9',
      invoice_id: '10',
      credit_card_number: '4140149827486249',
      credit_card_expiration_data: '',
      result: 'success',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
    }
    transaction = Transactions.new(data)
    assert_equal 9, transaction.id
    assert_equal 10, transaction.invoice_id
    assert_equal '4140149827486249', transaction.credit_card_number
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:53:59 UTC', transaction.created_at
    assert_equal '2012-03-27 14:54:10 UTC', transaction.updated_at
  end
end
