require_relative 'test_helper'
require_relative '../lib/invoices'

class InvoicesTest < Minitest::Test
  def test_invoices_has_attributes
    data = {
      id: "10",
      customer_id: "3",
      merchant_id: "86",
      status: "shipped",
      created_at: "2012-03-06 21:54:10 UTC",
      updated_at: "2012-03-06 21:54:10 UTC"
    }
    invoice = Invoices.new(data)
    assert_equal 10, invoice.id
    assert_equal 3, invoice.customer_id
    assert_equal 86, invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '2012-03-06 21:54:10 UTC', invoice.created_at
    assert_equal '2012-03-06 21:54:10 UTC', invoice.updated_at
  end
end
