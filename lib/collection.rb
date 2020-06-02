require_relative './collectable'

class Collection

  include Collectable

  attr_reader :collection

  def initialize
    @collection = []
  end

  def self.from_csv(file)
    new_collection = self.new
    new_collection.from_csv(file)
    new_collection
  end

end
