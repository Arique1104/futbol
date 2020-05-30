require "./lib/game_statistics"
require "minitest/autorun"
require "minitest/pride"

class GameStatisticsTest < MiniTest::Test

  def setup
    game_path = './game_stats_fixtures/games_fixtures.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = GameStatistics.from_csv(file_path_locations)
  end

  def test_it_exists_with_attributes
    assert_instance_of GameStatistics, @stat_tracker
    assert_equal './game_stats_fixtures/games_fixtures.csv', @stat_tracker.games
    assert_equal './game_stats_fixtures/teams_fixtures.csv', @stat_tracker.teams
    assert_equal './game_stats_fixtures/game_teams_fixtures.csv', @stat_tracker.game_teams
  end

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

  def test_it_counts_games_by_season
    game_path = './data/games.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = GameStatistics.from_csv(file_path_locations)

    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }

    assert_equal expected, stat_tracker.count_of_games_by_season
  end

  def test_it_can_collect_the_season_ids
    game_path = './data/games.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = GameStatistics.from_csv(file_path_locations)

    expected = stat_tracker.seasons_collection.uniq

    assert_equal 6, expected.size
    assert_includes expected, ("20122013")
    assert_includes expected, ("20162017")
    assert_includes expected, ("20142015")
    assert_includes expected, ("20152016")
    assert_includes expected, ("20132014")
    assert_includes expected, ("20172018")
  end

  def test_it_gets_average_goals_per_game

    game_path = './data/games.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = GameStatistics.from_csv(file_path_locations)

    expected = 4.22

    assert_equal expected, stat_tracker.average_goals_per_game

  end

  def test_it_gets_average_goals_by_season

    game_path = './data/games.csv'
    team_path = './game_stats_fixtures/teams_fixtures.csv'
    game_teams_path = './game_stats_fixtures/game_teams_fixtures.csv'

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = GameStatistics.from_csv(file_path_locations)

    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

    assert_equal expected, stat_tracker.average_goals_by_season

  end


end
