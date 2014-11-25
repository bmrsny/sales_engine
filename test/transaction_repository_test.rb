require_relative 'test_helper'
require_relative '../lib/transactions_repository'

class TransactionRepositoryTest < Minitest::Test

  def test_can_retrieve_attributes
    transactions = [
      {id: "11", invoice_id: "12", credit_card_number: "4800749911485986", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "12", invoice_id: "12", credit_card_number: "4800749911485986", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "13", invoice_id: "12", credit_card_number: "4536896898764278", credit_card_expiration_date: "", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" }
    ].map { |row| Transactions.new(row) }

    repository = TransactionsRepository.new(transactions)

    transaction1 = repository.find_by_id(11)
    assert_equal 1, transaction1.length

    transaction2 = repository.find_by_invoice_id(12)
    assert_equal 3, transaction2.length

    transaction3 = repository.find_by_credit_card_number("4800749911485986")
    assert_equal 2, transaction3.length

    transaction4 = repository.find_by_result("failed")
    assert_equal 2, transaction4.length
  end
end
