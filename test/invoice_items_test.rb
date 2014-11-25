require_relative 'test_helper'
require_relative '../lib/invoice_items'

class InvoiceItemsTest < Minitest::Test
  def test_invoice_items_has_attributes
    data = {
      id: '8',
      item_id: '534',
      invoice_id: '1',
      quantity: '6',
      unit_price: '76941',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:54:10 UTC'
    }
    invoice_item = InvoiceItems.new(data)
    assert_equal 8, invoice_item.id
    assert_equal 534, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 6, invoice_item.quantity
    assert_equal '76941', invoice_item.unit_price
    assert_equal '2012-03-27 14:53:59 UTC', invoice_item.created_at
    assert_equal '2012-03-27 14:54:10 UTC', invoice_item.updated_at
  end
end