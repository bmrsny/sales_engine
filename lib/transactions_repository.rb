require_relative 'transactions'
require_relative 'csv_handler'
class TransactionsRepository
  attr_reader :sales_engine,
              :data
  attr_accessor :transactions

  def initialize(file_name, parent)
    @data         = CSVHandler.load_data(file_name)
    @transactions = transactions.class == Array ? transactions : load_transactions
    @sales_engine = parent
  end

  def load_transactions
    transactions = data.map do |row|
      Transactions.new(row, self)
    end
  end

  def find_by_id(x)
    transactions.find do |transaction|
      transaction.id == x
    end
  end

  def find_all_by_id(id)
    transactions.select do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(x)
    transactions.find do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_all_by_invoice_id(x)
    transactions.select do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_by_credit_card_number(x)
    transactions.find do |transaction|
      transaction.credit_card_number == x
    end
  end

  def find_all_by_credit_card_number(x)
    transactions.select do |transaction|
      transaction.credit_card_number == x
    end
  end

  # def find_by_credit_card_expiration_date(x)
  #   transactions.find do |transaction|
  #     transaction.credit_card_expiration_date == x
  #   end
  # end

  # def find_all_by_credit_card_expiration_date(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_credit_card_expiration_date == x
  #   end
  # end

  def find_by_result(x)
    transactions.find do |transaction|
      transaction.result == x
    end
  end

  def find_all_by_result(x)
    transactions.select do |transaction|
      transaction.result == x
    end
  end

  def find_by_created_at(created_at)
    transactions.find {|transaction| transaction.created_at == created_at}
  end

  def find_all_by_created_at(created_at)
    transactions.select {|transaction| transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    transactions.find {|transaction| transaction.updated_at == updated_at}
  end

  def find_all_by_updated_at(updated_at)
    transactions.select {|transaction| transaction.updated_at == updated_at}
  end

  def random
    transactions.sample
  end

  def all
    transactions
  end

  def find_invoice_from(id)
    sales_engine.transaction_find_invoice_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
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
    transactions << Transactions.new(new_transaction, self)
    transactions.last
  end

  def next_id
    transactions.max_by { |transaction| transaction.id  }.id + 1
  end
end
