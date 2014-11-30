require_relative 'transactions'
require_relative 'csv_handler'
class TransactionsRepository
  attr_reader :transactions,
              :sales_engine,
              :data

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

  def find_by_invoice_id(x)
    transactions.find do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_by_credit_card_number(x)
    transactions.find do |transaction|
      transaction.credit_card_number == x
    end
  end

  # def find_by_credit_card_expiration_date(x)
  #   transactions.select do |transaction|
  #     transaction.credit_card_expiration_date == x
  #   end
  # end

  def find_by_result(x)
    transactions.find do |transaction|
      transaction.result == x
    end
  end

  def find_by_created_at(created_at)
    transactions.find {|transaction| transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    transactions.find {|transaction| transaction.updated_at == updated_at}
  end

  def find_all_by_created_at(created_at)
    transactions.select {|transaction| transaction.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    transactions.select {|transaction| transaction.updated_at == updated_at}
  end

  def find_all_by_id(x)
    transactions.select do |transaction|
      transaction.id == x
    end
  end

  def find_all_by_invoice_id(x)
    transactions.select do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_all_by_credit_card_number(x)
    transactions.select do |transaction|
      transaction.credit_card_number == x
    end
  end
  #
  # def find_all_by_credit_card_expiration_date(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_credit_card_expiration_date == x
  #   end
  # end
  #
  def find_all_by_result(x)
    transactions.select do |transaction|
      transaction.result == x
    end
  end

end
