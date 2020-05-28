require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of StatTracker, @stat_tracker
    assert_equal './data/games.csv', @stat_tracker.games
    assert_equal './data/teams.csv', @stat_tracker.teams
    assert_equal './data/game_teams.csv', @stat_tracker.game_teams
  end

  # def test_it_has_league_statistics
  #   assert_instance_of LeagueStatistics, @stat_tracker.league_statistics
  # end
end
