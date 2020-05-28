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

  # Game statistics
  def test_it_gets_highest_total_score
    assert_instance_of Integer, @stat_tracker.highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    assert_instance_of Integer, @stat_tracker.lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_gets_all_total_scores
    assert_instance_of Array, @stat_tracker.all_total_scores
    assert_equal 19, @stat_tracker.all_total_scores.count
    assert_equal true, @stat_tracker.all_total_scores.all? {|score| score.is_a?(Integer)}
  end

  def test_it_gets_percent_home_wins
    assert_instance_of Float, @stat_tracker.percentage_home_wins
    assert_equal 68.42, @stat_tracker.percentage_home_wins
  end

  def test_it_gets_percent_visitor_wins
    assert_instance_of Float, @stat_tracker.percentage_visitor_wins
    assert_equal 26.32, @stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_number_of_games_played
    assert_equal 19.0, @stat_tracker.total_games_played
  end

  def test_it_gets_percent_ties
    assert_equal 5.26, @stat_tracker.percentage_ties
  end

  def test_count_of_teams
    assert_instance_of Integer, @stat_tracker.count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_convert_team_id_to_name
    assert_equal "FC Dallas", @stat_tracker.team_name(6)
  end

  def test_team_scores
    expected = {
      "3"=>[2, 2, 1, 2, 1],
      "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
      "5"=>[0, 1, 1, 0],
      "17"=>[1, 2, 3, 2, 1, 3, 1],
      "16"=>[2, 1, 1, 0, 2, 2, 2],
      "9"=>[2, 1, 4],
      "8"=>[2, 3, 1]
    }
    assert_equal expected, @stat_tracker.team_scores
  end

  def test_teams_average_score
    expected = {
      "3"=>1.60,
      "6"=>2.67,
      "5"=>0.50,
      "17"=>1.86,
      "16"=>1.43,
      "9"=>2.33,
      "8"=>2.00
    }
    assert_equal expected, @stat_tracker.average_team_scores
  end

  def test_best_offense
    assert_instance_of String, @stat_tracker.best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_instance_of String, @stat_tracker.worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_visitor_scores
    expected = {
      "3"=>[2, 2, 1],
      "6"=>[2, 3, 3, 4],
      "5"=>[1, 0],
      "17"=>[1, 2, 1, 1],
      "16"=>[1, 0, 2],
      "9"=>[2, 1],
      "8"=>[1]
    }
    assert_equal expected, @stat_tracker.visitor_scores
  end

  def test_average_visitor_scores
    expected = {
      "3"=>1.67,
      "6"=>3.00,
      "5"=>0.50,
      "17"=>1.25,
      "16"=>1.00,
      "9"=>1.50,
      "8"=>1.00
    }
    assert_equal expected, @stat_tracker.average_visitor_scores
  end

  def test_highest_scoring_visitor
    assert_instance_of String, @stat_tracker.highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_instance_of String, @stat_tracker.lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end
end
