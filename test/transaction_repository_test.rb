require_relative 'test_helper'
require_relative '../lib/transactions_repository'

class TransactionsRepositoryTest < Minitest::Test

  class TransactionsRepositoryFinders < TransactionsRepositoryTest
    attr_reader :transactions,
                :repository,
                :sales_engine

    def setup
      @sales_engine = Minitest::Mock.new
      @transactions = TransactionsRepository.new('data/fixtures/transactions.csv', sales_engine)
    end

    def test_can_retrieve_attribute_id
      transaction = transactions.find_by_id(1)
      assert_equal 1, transaction.invoice_id
    end

    def test_can_retrieve_attribute_invoice_id
      transaction = transactions.find_by_invoice_id(12)
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_attribute_credit_card_number
      transaction = transactions.find_by_credit_card_number("4800749911485986")
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_attribute_result
      transaction = transactions.find_by_result("failed")
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_by_created_at
      transaction = transactions.find_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transaction.id
    end

    def test_can_retrieve_by_updated_at
      transaction = transactions.find_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transaction.id
    end

    def test_can_find_all_by_updated_at
      transaction = transactions.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transaction.count
    end

    def test_can_find_all_by_created_at
      transaction = transactions.find_all_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transaction.count
    end

    def test_can_find_all_by_id
      transaction = transactions.find_all_by_id(1)
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_invoice_id
      transaction = transactions.find_all_by_invoice_id(1)
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_credit_card_number
      transaction = transactions.find_all_by_credit_card_number("4654405418249632")
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_result
      transaction = transactions.find_all_by_result("success")
      assert_equal 20, transaction.count
    end

    def test_can_find_a_random_transaction
      transaction = transactions.random
      assert_instance_of(Transactions, transaction)
    end

    def test_it_has_a_sales_engine
      assert transactions.sales_engine
    end

    def test_the_repository_is_not_empty
      refute transactions.transactions.empty?
    end

    def test_it_delegates_items_to_the_sales_engine
      sales_engine.expect(:transaction_find_invoice_by_id, nil, [9])
      transactions.find_invoice_from(9)
      sales_engine.verify
    end
  end
end
