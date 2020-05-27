require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/game_teams_fixture.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of StatTracker, @stat_tracker
    assert_equal './fixtures/games_fixture.csv', @stat_tracker.games
    assert_equal './fixtures/teams_fixture.csv', @stat_tracker.teams
    assert_equal './fixtures/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  def test_it_gets_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_gets_all_total_scores
    assert_instance_of Array, @stat_tracker.all_total_scores
    assert_equal 19, @stat_tracker.all_total_scores.count
    assert_equal true, @stat_tracker.all_total_scores.all? {|score| score.is_a?(Integer)}
  end


end
