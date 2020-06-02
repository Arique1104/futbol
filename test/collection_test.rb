require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/collection"

class CollectionTest < MiniTest::Test

	def setup
    @books = mock('Books')
    @collection = Collection.collect(@books)
		@collection.expects(:load_csv).returns(nil)
	end

  def test_it_exists_and_has_attributes
    assert_instance_of Collection, @collection
    assert_equal [@books], @collection.collection
  end


end
