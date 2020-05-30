require "./lib/season_statistics"
require "minitest/autorun"
require "minitest/pride"

class SeasonStatisticsTest < MiniTest::Test

  def setup
    # game_path =
    # team_path =
    # game_teams_path =

    file_path_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = SeasonStatistics.from_csv(file_path_locations)
  end

  # Name of the Coach with the best win percentage for the season
  def test_it_gets_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  # Name of the Coach with the worst win percentage for the season
  def test_it_gets_worst_coach
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    # assert_equal("Craig MacTavish").or(eq("Ted Nolan")), @stat_tracker.worst_coach("20142015")
  end

  # Name of the Team with the best ratio of shots to goals for the season
  def test_it_gets_most_accurate_team
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  # Name of the Team with the worst ratio of shots to goals for the season
  def test_it_gets_least_accurate_team
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  # Name of the Team with the most tackles in the season
  def test_it_gets_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  # Name of the Team with the fewest tackles in the season
  def test_it_gets_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

end
