require 'csv'

module Loadable

  def from_csv(file)
    CSV.foreach(file, :headers => true, :header_converters => :symbol) { |row| load_csv (row) }
  end

  def load_csv(row)
    @collection << @statistics.new(row)
  end

end
