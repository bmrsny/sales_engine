require_relative 'transactions'
class TransactionsRepository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def self.build_transactions(filename="./data/transactions.csv")
    data = Csv.open(filename, headers: true, header_converters: :symbol)
    rows = data.map { |row| Transactons.new(row) }
    new(rows)
  end

  def find_by_id(x)
    transactions.select do |transaction|
      transaction.id == x
    end
  end

  def find_by_invoice_id(x)
    transactions.select do |transaction|
      transaction.invoice_id == x
    end
  end

  def find_by_credit_card_number(x)
    transactions.select do |transaction|
      transaction.credit_card_number == x
    end
  end

  # def find_by_credit_card_expiration_date(x)
  #   transactions.select do |transaction|
  #     transaction.credit_card_expiration_date == x
  #   end
  # end

  def find_by_result(x)
    transactions.select do |transaction|
      transaction.result == x
    end
  end

  # def find_all_by_id(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_id == x
  #   end
  # end
  #
  # def find_all_by_invoice_id(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_invoice_id == x
  #   end
  # end
  #
  # def find_all_by_credit_card_number(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_credit_card_number == x
  #   end
  # end
  #
  # def find_all_by_credit_card_expiration_date(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_credit_card_expiration_date == x
  #   end
  # end
  #
  # def find_all_by_result(x)
  #   transactions.select do |transaction|
  #     transaction.all_by_result == x
  #   end
  # end

end
