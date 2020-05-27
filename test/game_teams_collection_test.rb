require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/game_teams_collection"
require "CSV"
require "./lib/stat_tracker"
require "./runner"

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @@game_teams_path = './data/game_teams.csv'

    StatTracker.from_csv(@@game_teams_path)

    @game_teams_collection = GameTeamsCollection.new('./fixtures/game_teams_fixture.csv')
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
  end

  def test_it_has_attributes_for_fixture
    expected_coaches = ["John Tortorella", "Claude Julien"]
    assert_equal expected_coaches, @game_teams_collection.head_coaches

    expected_team_ids = ["3", "6", "29"]
    assert_equal expected_team_ids, @game_teams_collection.team_ids

    # expected_results = {game_id => }
    @game_teams_collection.results

    @game_teams_collection.game_ids
  end

  def test_most_accurate_team_test_for_fixture
    assert_equal "Sporting Kansas City", @game_teams_collection.most_accurate_team
  end

end
