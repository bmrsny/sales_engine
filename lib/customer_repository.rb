require_relative 'customer'
class CustomerRepository
  attr_reader :customer

  def initialize(customers)
    @customers = customers
  end

  def find_by_id(x)
    customers.select do |customer|
      customer.id == x
    end
  end

  def find_by_name(x)
    customers.select do |customer|
      customer.name == x
    end
  end
end
