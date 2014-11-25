require_relative 'test_helper'
require_relative '../lib/items_repository'

class ItemsRepositoryTest < Minitest::Test
  attr_reader :repository, :items

  def setup
    @items = [
      {id:"1", name:"Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id:"1", created_at:"2012-03-27 14:53:59 UTC", updated_at:"2012-03-27 14:53:59 UTC" },
      {id:"2", name:"Item Autem Minima",description: "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.",unit_price:"67076", merchant_id:"1", created_at:"2012-03-27 14:53:59 UTC", updated_at:"2012-03-27 14:53:59 UTC" },
      {id:"4", name:"Item Nemo Facere", description: "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.", unit_price: "4291", merchant_id:"1", created_at:"2012-03-27 14:53:59 UTC", updated_at:"2012-03-27 14:53:59 UTC" }
    ].map { |row| Items.new(row) }

  @repository = ItemsRepository.new(items)
  end

  def test_can_retrievee_id
    repository
    items = repository.find_by_id(1)
    assert_equal 1, items.length
  end

  def test_can_retrieve_by_name
    repository
    items = repository.find_by_name("Item Autem Minima")
    assert_equal 1, items.length
  end

  def test_can_find_by_merchant_id
    repository
    items = repository.find_by_id(4)
    assert_equal 1, items.length
  end
end
