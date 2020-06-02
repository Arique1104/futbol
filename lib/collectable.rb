require 'csv'

module Collectable

  def from_csv(file)
    CSV.foreach(file, :headers => true, :header_converters => :symbol) { |row| collect_statistics(row) }
  end

  def collect_statistics(row)
    @collection << @statistics.new(row)
  end

end
