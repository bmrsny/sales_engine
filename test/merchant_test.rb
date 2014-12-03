require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :merchant,
              :parent

  def setup
    data = {
      id: '1',
      name: 'Shroeder-Jerde',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    }
    @parent   = Minitest::Mock.new
    @merchant = Merchant.new(data, parent)
  end

  def test_it_exists
    assert Merchant
  end

  def test_merchant_has_attributes
    assert_equal 1, merchant.id
    assert_equal 'Shroeder-Jerde', merchant.name
    assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at
    assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at
  end

  def test_it_delegates_items_to_its_repository
    parent.expect(:find_items_from, nil, [1])
    merchant.items
    parent.verify
  end

  def test_it_delegates_invoice_to_its_repository
    parent.expect(:find_invoice_from, nil, [1])
    merchant.invoice
    parent.verify
  end
end
