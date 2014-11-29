require_relative 'test_helper'
require_relative '../lib/transactions_repository'

class TransactionRepositoryTest < Minitest::Test
    attr_reader :transactions,
                :repository,
                :sales_engine

    def setup
      @sales_engine = sales_engine
      @repository = TransactionsRepository.new('data/fixtures/transactions.csv', sales_engine)
    end

    def test_can_retrieve_attribute_id
      transactions = repository.find_by_id(1)
      assert_equal 1, transactions.invoice_id
    end

    def test_can_retrieve_attribute_invoice_id
      transactions = repository.find_by_invoice_id(12)
      assert_equal 11, transactions.id
    end

    def test_can_retrieve_attribute_credit_card_number
      transactions = repository.find_by_credit_card_number("4800749911485986")
      assert_equal 11, transactions.id
    end

    def test_can_retrieve_attribute_result
      transactions = repository.find_by_result("failed")
      assert_equal 11, transactions.id
    end

    def test_can_retrieve_by_created_at
      transactions = repository.find_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transactions.id
    end

    def test_can_retrieve_by_updated_at
      transactions = repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 3, transactions.id
    end

    def test_can_find_all_by_updated_at
      transactions = repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transactions.count
    end

    def test_can_find_all_by_created_at
      transactions = repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 20, transactions.count
    end

    def test_can_find_all_by_id
      transactions = repository.find_all_by_id(1)
      assert_equal 1, transactions.count
    end

    def test_can_find_all_by_invoice_id
      transactions = repository.find_all_by_invoice_id(1)
      assert_equal 1, transactions.count
    end

    def test_can_find_all_by_credit_card_number
      transactions = repository.find_all_by_credit_card_number("4654405418249632")
      assert_equal 1, transactions.count
    end

    def test_can_find_all_by_result
      transactions = repository.find_all_by_result("success")
      assert_equal 20, transactions.count
    end
end
