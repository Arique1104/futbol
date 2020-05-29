require "./lib/team_statistics"
require "minitest/autorun"
require "minitest/pride"

class TeamStatisticsTest < MiniTest::Test

  def setup
    game_path = './team_stats_fixtures/games_fixtures.csv'
    team_path = './team_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './team_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = TeamStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of TeamStatistics, @stat_tracker
    assert_equal './team_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './team_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './team_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end


  def test_can_find_home_or_away_team_id
    assert_equal true, @stat_tracker.home_or_away_team_id(6)
  end

  def test_it_can_find_season_home_team_losses
    assert_equal 0, @stat_tracker.season_home_team_losses(6)
  end

# out of 14 games for team id 6
# (the id flops back and forth between home id and away id)
# 2012 2013
# post season away wins: 4
# post season away losses:
# post season away ties:
# post season home wins: 5
# post season home losses:
# post season home ties:

# = 9 wins 0 losses 0 ties post season

# 2013 2014
# regular season away wins:
# regular season away losses:
# regular season away ties: 1
# regular season home wins: 4
# regular season home losses:
# regular season home ties:

# = 4 wins 0 losses 1 tie regular season

# Ask about ties and how they factor in. I know the above who clearly
# indicate that the post season was the best win % season, however over the rest of the data
# we need to know how ties factor in as they could dramatically change the data.


end
