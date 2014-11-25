require_relative 'test_helper'
require_relative '../lib/invoice_items_repository'

class InvoiceItemsRepositoryTest < Minitest::Test

  def test_can_retrieve_attributes
    invoice_items = [
      {id: "25", item_id: "928", invoice_id: "5", quantity: "9", unit_price: "32346", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "26", item_id: "936", invoice_id: "5", quantity: "10", unit_price: "73408", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" },
      {id: "26", item_id: "1867", invoice_id: "6", quantity: "2", unit_price: "8342", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC" }
    ].map { |row| InvoiceItems.new(row) }

    repository = InvoiceItemsRepository.new(invoice_items)

    transaction1 = repository.find_by_id(26)
    assert_equal 2, transaction1.length

    transaction2 = repository.find_by_item_id(928)
    assert_equal 1, transaction2.length

    transaction3 = repository.find_by_invoice_id(5)
    assert_equal 2, transaction3.length

    transaction4 = repository.find_by_quantity(9)
    assert_equal 1, transaction4.length

    transaction5 = repository.find_by_unit_price("8342")
    assert_equal 1, transaction5.length
  end
end
