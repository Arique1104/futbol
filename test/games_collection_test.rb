require "minitest/autorun"
require "minitest/pride"
require "./lib/games_collection"
require "./lib/games"

class GamesCollectionTest < MiniTest::Test

	def setup
    @games_csv_location = "./data/games.csv"
    @games_collection = GamesCollection.new
	end

	def test_it_exists_with_attributes
		assert_instance_of GamesCollection, @games_collection
		assert_equal Games, @games_collection.statistics
		assert_equal [], @games_collection.collection
	end

  def test_it_can_load_csv
    @games_collection.load_csv(@games_csv_location)
    assert_equal 7441, @games_collection.collection.count
    all_games_object = @games_collection.collection.all? do |object|
      object.is_a?(Games)
    end
    assert_equal true, all_games_object
  end
end
