require "minitest/autorun"
require "minitest/pride"
require "./lib/collection"

class CollectionTest < MiniTest::Test

	def setup
    @collection = Collection.new
	end

  def test_it_exists_with_attributes
    assert_instance_of Collection, @collection
    assert_equal [], @collection.collection
  end

end
