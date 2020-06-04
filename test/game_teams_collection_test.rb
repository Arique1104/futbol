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
    assert_equal true,  @game_teams_collection.collection.all? { |object| object.is_a?(GameTeams) }

    game_teams_collection = GameTeamsCollection.from_csv(@game_teams_csv_location)

    assert_equal 14882, game_teams_collection.count
    assert_equal true,  game_teams_collection.all? { |object| object.is_a?(GameTeams) }
  end

  def test_it_can_load_statistics
    mock_game_teams_params = {
      :game_id => "2012030221",
      :team_id => "3",
      :hoa => "away",
      :result => "LOSS",
      :settled_in => "OT",
      :head_coach => "John Tortorella",
      :goals => "2",
      :shots => "8",
      :tackles => "44",
      :pim => "8",
      :powerplayopportunities => "3",
      :powerplaygoals => "0",
      :faceoffwinpercentage => "44.8",
      :giveaways => "17",
      :takeaways => "7"
    }

    @game_teams_collection.load_statistics(mock_game_teams_params)

    assert_equal 1, @game_teams_collection.collection.count
    assert_equal true,  @game_teams_collection.collection.all? { |object| object.is_a?(GameTeams) }
  end

end
