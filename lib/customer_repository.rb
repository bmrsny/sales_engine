require_relative 'customer'
class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def self.build_customers(filename='./data/customer.csv')
    data = Csv.open(filename, headers: true, header_converters: :symbol)
    rows = data.map { |row| Customer.new(row) }
    new(rows)
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

    def find_all_by_first_name(first_name)
      customers.select do |customer|
        customer.first_name == first_name
      end
    end

    def random
      customers.sample
    end

    def all
      customers
    end
end
