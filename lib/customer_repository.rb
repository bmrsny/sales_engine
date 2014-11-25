require_relative 'customer'
class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers.map { |data| Customer.new(data) }
  end

  def find_by_id(x)
    customers.select do |customer|
      customer.id == x
    end
  end

  def find_by_first_name(x)
    customers.select do |customer|
      customer.first_name == x
    end
  end

    def find_by_last_name(x)
      customers.select do |customer|
        customer.last_name == x
      end
    end
end
