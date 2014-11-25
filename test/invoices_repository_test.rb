require_relative 'test_helper'
require_relative '../lib/invoices_repository'

class InvoicesRepositoryTest < Minitest::Test
  attr_reader :invoices, :repository

  def setup
    @invoices = [
      {id: "8", customer_id: "3", merchant_id: "27", status: "shipped", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC" },
      {id: "9", customer_id: "2", merchant_id: "27", status: "shipped", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-07 12:54:10 UTC" },
      {id: "10", customer_id: "3", merchant_id: "86", status: "shipped", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC" }
    ].map { |row| Invoices.new(row) }

    @repository = InvoicesRepository.new(invoices)
  end

  def test_can_retrieve_attribute_id
    repository
    invoices = repository.find_by_id(8)
    assert_equal 1, invoices.length
  end

  def test_can_retrieve_attribute_customer_id
    repository
    invoices = repository.find_by_customer_id(3)
    assert_equal 2, invoices.length
  end

  def test_can_retrieve_attribute_merchant_id
    repository
    invoices = repository.find_by_merchant_id(27)
    assert_equal 2, invoices.length
  end

  def test_can_retrieve_attribute_status
    repository
    invoices = repository.find_by_status("shipped")
    assert_equal 3, invoices.length
  end

end
