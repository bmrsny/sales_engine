require_relative 'test_helper'
require_relative '../lib/items'

class ItemsTest < Minitest::Test
  def test_items_have_attributes
    data = {
      id: 1,
      name: "Item Qui Esse",
      description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price: "75107",
      merchant_id: 1,
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }

    items = Items.new(data)
    assert_equal 1, items.id
    assert_equal "Item Qui Esse", items.name
    assert_includes(items.description,"Nihil autem sit odio")
    assert_equal 1, items.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", items.created_at
    assert_equal "2012-03-27 14:53:59 UTC", items.updated_at
  end
end
