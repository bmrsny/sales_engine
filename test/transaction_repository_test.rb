require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  class TransactionRepositoryFinders < TransactionRepositoryTest
    attr_reader :transactions,
                :repository,
                :sales_engine

    def setup
      @sales_engine = Minitest::Mock.new
      @repository = TransactionRepository.new('data/fixtures/transactions.csv', sales_engine)
    end

    def test_can_retrieve_attribute_id
      transaction = repository.find_by_id(1)
      assert_equal 1, transaction.invoice_id
    end

    def test_can_retrieve_attribute_invoice_id
      transaction = repository.find_by_invoice_id(12)
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_attribute_credit_card_number
      transaction = repository.find_by_credit_card_number("4800749911485986")
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_attribute_result
      transaction = repository.find_by_result("failed")
      assert_equal 11, transaction.id
    end

    def test_can_retrieve_by_created_at
      transaction = repository.find_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transaction.id
    end

    def test_can_retrieve_by_updated_at
      transaction = repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transaction.id
    end

    def test_can_find_all_by_updated_at
      transaction = repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transaction.count
    end

    def test_can_find_all_by_created_at
      transaction = repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transaction.count
    end

    def test_can_find_all_by_id
      transaction = repository.find_all_by_id(1)
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_invoice_id
      transaction = repository.find_all_by_invoice_id(1)
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_credit_card_number
      transaction = repository.find_all_by_credit_card_number("4654405418249632")
      assert_equal 1, transaction.count
    end

    def test_can_find_all_by_result
      transaction = repository.find_all_by_result("success")
      assert_equal 20, transaction.count
    end

    def test_can_find_a_random_transaction
      transaction = repository.random
      assert_instance_of(Transaction, transaction)
    end

    def test_it_has_a_sales_engine
      assert repository.sales_engine
    end

    def test_the_repository_is_not_empty
      refute repository.repository.empty?
    end

    def test_it_delegates_items_to_the_sales_engine
      sales_engine.expect(:find_transaction_from_invoice_id, nil, [9])
      repository.find_transactions_from(9)
      sales_engine.verify
    end
  end
end
