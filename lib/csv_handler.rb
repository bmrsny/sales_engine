require 'csv'

class CSVHandler
  def self.load_data(file_name)
    CSV.open(file_name, headers: true, header_converters: :symbol)
  end
end
