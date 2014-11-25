require_relative 'invoice_items'

class InvoiceItemsRepository
  attr_reader :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items.map { |data| Merchant.new(data) }
  end

  def find_by_id(x)
    invoice_items.select do |invoice_item|
      invoice_item.id == x
    end
  end

  def find_by_item_id(x)
    invoice_items.select do |invoice_item|
      invoice_item.item_id == x
    end
  end

  def find_by_invoice_id(x)
    invoice_items.select do |invoice_item|
      invoice_item.invoice_id == x
    end
  end

  def find_by_quantity(x)
    invoice_items.select do |invoice_item|
      invoice_item.quantity == x
    end
  end

  def find_by_unit_price(x)
    invoice_items.select do |invoice_item|
      invoice_item.unit_price == x
    end
  end

  # def find_all_by_id(x)
  #   invoice_items.select do |invoice_item|
  #     invoice_item.all_by_id == x
  #   end
  # end
  #
  # def find_all_by_item_id(x)
  #   invoice_items.select do |invoice_item|
  #     invoice_item.all_by_item_id == x
  #   end
  # end
  #
  # def find_all_by_invoice_id(x)
  #   invoice_items.select do |invoice_item|
  #     invoice_item.all_by_invoice_id == x
  #   end
  # end
  #
  # def find_all_by_quantity(x)
  #   invoice_items.select do |invoice_item|
  #     invoice_item.all_by_quantity == x
  #   end
  # end
  #
  # def find_all_by_unit_price(x)
  #   invoice_items.select do |invoice_item|
  #     invoice_item.all_by_unit_price == x
  #   end
  # end

end
