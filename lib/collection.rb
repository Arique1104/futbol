require 'csv'

class Collection
  attr_reader :collection

  def initialize
    @collection = []
  end

  def self.from_csv(csv_location)
    new_collection = self.new
    new_collection.load_csv(csv_location)
    new_collection.collection
  end

  def load_csv(csv_location)
    CSV.foreach(csv_location, :headers => true, :header_converters => :symbol) do |row|
      load_statistics(row)
    end
  end

  def load_statistics(row)
    @collection << @statistics.new(row) unless @statistics.nil?
  end

end
