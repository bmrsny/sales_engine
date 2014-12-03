require_relative 'transaction'
require_relative 'csv_handler'
class TransactionRepository
  attr_reader   :sales_engine,
                :data
  attr_accessor :repository

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @repository   = repository.class == Array ? repository : load_transactions
    @sales_engine = parent
  end

  def load_transactions
    repository = data.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_id(x)
    repository.find do |transaction|
      transaction.id == x
    end
  end

  def find_all_by_id(id)
    repository.select do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(x)
    repository.find do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_all_by_invoice_id(x)
    repository.select do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_by_credit_card_number(x)
    repository.find do |transaction|
      transaction.credit_card_number == x
    end
  end

  def find_all_by_credit_card_number(x)
    repository.select do |transaction|
      transaction.credit_card_number == x
    end
  end

  # def find_by_credit_card_expiration_date(x)
  #   repository.find do |transaction|
  #     transaction.credit_card_expiration_date == x
  #   end
  # end

  # def find_all_by_credit_card_expiration_date(x)
  #   repository.select do |transaction|
  #     transaction.all_by_credit_card_expiration_date == x
  #   end
  # end

  def find_by_result(x)
    repository.find do |transaction|
      transaction.result == x
    end
  end

  def find_all_by_result(x)
    repository.select do |transaction|
      transaction.result == x
    end
  end

  def find_by_created_at(created_at)
    repository.find {|transaction| transaction.created_at == created_at}
  end

  def find_all_by_created_at(created_at)
    repository.select {|transaction| transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    repository.find {|transaction| transaction.updated_at == updated_at}
  end

  def find_all_by_updated_at(updated_at)
    repository.select {|transaction| transaction.updated_at == updated_at}
  end

  def random
    repository.sample
  end

  def all
    repository
  end

  def find_invoice_from(id)
    sales_engine.transaction_find_invoice_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def add(credit_card_number, credit_card_expiration, result, invoice_id)
    new_transaction = {
      :id                          => next_id,
      :invoice_id                  => invoice_id,
      :credit_card_number          => credit_card_number,
      :credit_card_expiration_date => credit_card_expiration,
      :result                      => result,
      :created_at                  => Date.today.to_s,
      :updated_at                  => Date.today.to_s
    }
    repository << Transaction.new(new_transaction, self)
    repository.last
  end

  def next_id
    repository.max_by { |transaction| transaction.id  }.id + 1
  end
end
