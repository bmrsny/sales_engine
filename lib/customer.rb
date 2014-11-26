require 'date'
class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(data)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
  end
end
cust = Customer.new({
  id: '1',
  first_name: 'Joey',
  last_name: 'Ondricka',
  created_at: '2012-03-27 14:54:09 UTC',
  updated_at: '2012-03-27 14:54:09 UTC'
  })
cust.created_at
