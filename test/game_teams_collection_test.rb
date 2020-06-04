require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game_teams_collection"

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @game_teams_csv_location = './data/game_teams.csv'
    @game_teams_collection = GameTeamsCollection.new
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
    assert_equal GameTeams, @game_teams_collection.statistics
    assert_equal [], @game_teams_collection.collection
  end

  def test_it_can_load_a_csv_file
    @game_teams_collection.load_csv(@game_teams_csv_location)

    assert_equal 14882, @game_teams_collection.collection.count

    all_game_teams = @game_teams_collection.collection.all? do |object|
      object.is_a?(GameTeams)
    end

    assert_equal true, all_game_teams

    game_teams_collection = GameTeamsCollection.from_csv(@game_teams_csv_location)
    assert_equal 14882, game_teams_collection.count
  end

end
