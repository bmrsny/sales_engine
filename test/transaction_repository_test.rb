require_relative 'test_helper'
require_relative '../lib/transactions_repository'

class TransactionRepositoryTest < Minitest::Test
    attr_reader :transactions, :repository

    def setup
      @transactions = [
      {id: "11", invoice_id: "12", credit_card_number: "4800749911485986", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "12", invoice_id: "12", credit_card_number: "4800749911485986", credit_card_expiration_date: "", result: "failed", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "13", invoice_id: "12", credit_card_number: "4536896898764278", credit_card_expiration_date: "", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" }
    ].map { |row| Transactions.new(row) }

      @repository = TransactionsRepository.new(transactions)
    end

    def test_can_retrieve_attribute_id
      # repository = TransactionsRepository.new(transactions)
      repository
      transactions = repository.find_by_id(11)
      assert_equal 1, transactions.length
    end

    def test_can_retrieve_attribute_invoice_id
      # repository = TransactionsRepository.new(transactions)
      repository
      transactions = repository.find_by_invoice_id(12)
      assert_equal 3, transactions.length
    end

    def test_can_retrieve_attribute_credit_card_number
      # repository = TransactionsRepository.new(transactions)
      repository
      transactions = repository.find_by_credit_card_number("4800749911485986")
      assert_equal 2, transactions.length
    end

    def test_can_retrieve_attribute_result
      # repository = TransactionsRepository.new(transactions)
      repository
      transactions = repository.find_by_result("failed")
      assert_equal 2, transactions.length
    end
end
