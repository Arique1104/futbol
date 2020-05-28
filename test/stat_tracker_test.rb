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
    skip
    assert_instance_of StatTracker, @stat_tracker
    assert_equal './fixtures/games_fixture.csv', @stat_tracker.games
    assert_equal './fixtures/teams_fixture.csv', @stat_tracker.teams
    assert_equal './fixtures/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  # Game statistics
  def test_it_gets_highest_total_score
    skip
    assert_instance_of Integer, @stat_tracker.highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    skip
    assert_instance_of Integer, @stat_tracker.lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_gets_all_total_scores
    skip
    assert_instance_of Array, @stat_tracker.all_total_scores
    assert_equal 19, @stat_tracker.all_total_scores.count
    assert_equal true, @stat_tracker.all_total_scores.all? {|score| score.is_a?(Integer)}
  end

  def test_it_gets_percent_home_wins
    skip
    assert_instance_of Float, @stat_tracker.percentage_home_wins
    assert_equal 68.42, @stat_tracker.percentage_home_wins
  end

  def test_it_gets_percent_visitor_wins
    skip
    assert_instance_of Float, @stat_tracker.percentage_visitor_wins
    assert_equal 26.32, @stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_number_of_games_played
    skip
    assert_equal 19.0, @stat_tracker.total_games_played
  end

  def test_it_gets_percent_ties
    skip
    assert_equal 5.26, @stat_tracker.percentage_ties
  end

  def test_for_winningest_coach
    skip
    #pause

  end

  def test_by_game_by_season
    assert_equal 16, @stat_tracker.games_by_season("20142015").count
    assert_equal 0, @stat_tracker.games_by_season("20202021").count
  end

  def test_wins_per_team
    
  end
end
