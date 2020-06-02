require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game_teams_collection"

class GameTeamsCollectionTest < Minitest::Test
  game_teams_csv_location = './data/game_teams.csv'
  @@game_teams_collection = GameTeamsCollection.collect(game_teams_csv_location)

  def test_it_exists
    assert_instance_of GameTeamsCollection, @@game_teams_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @@game_teams_collection.collection
    assert_equal 14882, @@game_teams_collection.collection.count
  end

end
