require 'csv'

class Collection

  attr_reader :collection

  def initialize
    @collection = []
  end

  def self.from_csv(file)
    new_collection = self.new
    new_collection.from_csv(file)
    new_collection
  end

  def from_csv(file)
    CSV.foreach(file, :headers => true, :header_converters => :symbol) do |row|
      load_csv(row)
    end
  end

  def load_csv(database)
    @collection << @statistics.new(database)
  end


end
