require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :repository,
              :parent

  def setup
    data = {
      id: 1,
      name: "Item Qui Esse",
      description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price: "75107",
      merchant_id: 3,
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
    @parent      = Minitest::Mock.new
    @repository  = Item.new(data, parent)
  end

  def test_it_exists
    assert Item
  end

  def test_items_have_attributes
    assert_equal 1, repository.id
    assert_equal "Item Qui Esse", repository.name
    assert_includes(repository.description,"Nihil autem sit odio")
    assert_equal BigDecimal.new('75107')/100, repository.unit_price
    assert_equal 3, repository.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", repository.created_at
    assert_equal "2012-03-27 14:53:59 UTC", repository.updated_at
  end

  def test_it_delegates_merchants_to_its_repository
    parent.expect(:find_merchants_from, nil, [3])
    repository.merchant
    parent.verify
  end

  def test_it_delegates_invoice_items_to_its_repository
    parent.expect(:find_invoice_items_from, nil, [1])
    repository.invoice_items
    parent.verify
  end
end
