require_relative 'customer'
require_relative 'csv_handler'
class CustomerRepository
  attr_reader :customers,
              :sales_engine,
              :data

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @customers    = load_customer
    @sales_engine = parent
  end

  def load_customer
    data.map { |row| Customer.new(row, self) }
  end

  def find_by_id(x)
    customers.find do |customer|
      customer.id == x
    end
  end

  def find_by_first_name(x)
    customers.find do |customer|
      customer.first_name == x
    end
  end

    def find_by_last_name(x)
      customers.find do |customer|
        customer.last_name == x
      end
    end

    def find_all_by_first_name(first_name)
      customers.select do |customer|
        customer.first_name == first_name
      end
    end

    def find_all_by_last_name(last_name)
      customers.select do |customer|
        customer.last_name == last_name
      end
    end

    def find_by_created_at(created_at)
      customers.find do |customer|
        customer.created_at == created_at
      end
    end

    def find_by_updated_at(updated_at)
      customers.find do |customer|
        customer.updated_at == updated_at
      end
    end

    def find_all_by_created_at(created_at)
      customers.select do |customer|
        customer.created_at == created_at
      end
    end

    def find_all_by_updated_at(updated_at)
      customers.select do |customer|
        customer.updated_at == updated_at
      end
    end

    def random
      customers.sample
    end

    def all
      customers
    end
end
