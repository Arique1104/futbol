require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"

class StatTrackerTest < MiniTest::Test

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  @@stat_tracker ||= StatTracker.from_csv(locations)

  def test_it_exists
    assert_instance_of StatTracker, @@stat_tracker
  end

  # Game stats HELPER method
  def test_it_can_get_percentage_out_of_total_games
    assert_equal 0.25, @@stat_tracker.get_percentage(1860)
  end

  def test_it_gets_highest_total_score
    assert_equal 11, @@stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    assert_equal 0, @@stat_tracker.lowest_total_score
  end

  # Game stats HELPER method
  def test_it_gets_all_total_scores
    assert_equal 7441, @@stat_tracker.all_total_scores.count
  end

  def test_it_gets_percentage_home_wins
    assert_equal 0.44, @@stat_tracker.percentage_home_wins
  end

  def test_it_gets_percentage_visitor_wins
    assert_equal 0.36, @@stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_percentage_ties
    assert_equal 0.20, @@stat_tracker.percentage_ties
  end

  def test_it_gets_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @@stat_tracker.count_of_games_by_season
  end

  def test_it_gets_average_goals_per_game
    assert_equal 4.22, @@stat_tracker.average_goals_per_game
  end

  def test_it_gets_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @@stat_tracker.average_goals_by_season
  end

  # League Statistics count_of_teams method DONE
  def test_it_gets_count_of_teams
    assert_equal 32, @@stat_tracker.count_of_teams
  end

  # League Statistics count_of_teams method HELPER DONE
  def test_convert_team_id_to_name
    assert_equal "FC Dallas", @@stat_tracker.team_name("6")
  end

  # League Statistics HELPER HELPER method refactored into one
  def test_it_can_get_scores_by_team
    assert_equal Hash, @@stat_tracker.scores("away").class
    assert_equal 32, @@stat_tracker.scores("away").count
    assert_equal true, @@stat_tracker.scores("away").all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  # League Statistics HELPER method
  def test_it_can_get_all_team_scores
    assert_equal Hash, @@stat_tracker.team_scores.class
    assert_equal 32, @@stat_tracker.team_scores.count
    assert_equal true, @@stat_tracker.team_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
    @@stat_tracker.stubs(:scores).returns({"3"=>[2,4]})
    expected = {"3"=>[2,4]}
    assert_equal expected, @@stat_tracker.visitor_scores
  end

  # League Statistics HELPER method
  def test_it_can_get_visitor_scores
    assert_equal Hash, @@stat_tracker.visitor_scores.class
    assert_equal 32, @@stat_tracker.visitor_scores.count
    assert_equal true, @@stat_tracker.visitor_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
    @@stat_tracker.stubs(:scores).returns({"3"=>[2,2]})
    expected = {"3"=>[2,2]}
    assert_equal expected, @@stat_tracker.visitor_scores
  end

  # League Statistics HELPER method
  def test_it_can_get_home_team_scores
    assert_equal Hash, @@stat_tracker.home_team_scores.class
    assert_equal 32, @@stat_tracker.home_team_scores.count
    assert_equal true, @@stat_tracker.home_team_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
    @@stat_tracker.stubs(:scores).returns({"3"=>[3,2]})
    expected = {"3"=>[3,2]}
    assert_equal expected, @@stat_tracker.visitor_scores
  end

    # League Statistics HELPER method
  def test_average_scores
    visitor_scores = @@stat_tracker.visitor_scores
      expected = {
        "3"=>2.15,
        "6"=>2.25,
        "5"=>2.18,
        "17"=>2.04,
        "16"=>2.10,
        "9"=>2.01,
        "8"=>2.01,
        "30"=>2.01,
        "26"=>2.03,
        "19"=>2.04,
        "24"=>2.14,
        "2"=>2.10,
        "15"=>2.20,
        "20"=>1.93,
        "14"=>2.12,
        "28"=>2.13,
        "4"=>1.97,
        "21"=>1.91,
        "25"=>2.12,
        "13"=>1.95,
        "18"=>2.05,
        "10"=>1.95,
        "29"=>2.12,
        "52"=>2.04,
        "54"=>2.10,
        "1"=>1.90,
        "12"=>2.02,
        "23"=>1.94,
        "22"=>2.03,
        "7"=>1.88,
        "27"=>1.85,
        "53"=>1.85
      }
    assert_equal expected, @@stat_tracker.average_scores(visitor_scores)
  end

    # League Statistics HELPER method
  def test_average_visitor_scores
    @@stat_tracker.expects(:visitor_scores).returns({"3" => [1,2,3]})
    expected = {
      "3" => 2.0
    }
    assert_equal expected, @@stat_tracker.average_visitor_scores
  end

    # League Statistics HELPER method
  def test_average_team_scores
    @@stat_tracker.expects(:team_scores).returns({"3" => [2,2,3]})
    expected = {
      "3" => 2.33
    }
    assert_equal expected, @@stat_tracker.average_team_scores
  end

    # League Statistics HELPER method
  def test_average_home_team_scores
    @@stat_tracker.expects(:team_scores).returns({"3" => [4,2,3]})
    expected = {
      "3" => 3.0
    }
    assert_equal expected, @@stat_tracker.average_team_scores
  end

    # League Statistics HELPER method
  def test_highest_score
    average_visitor_scores = @@stat_tracker.average_visitor_scores
    assert_equal "FC Dallas", @@stat_tracker.highest_score(average_visitor_scores)
  end

    # League Statistics method
  def test_it_gets_best_offense
    assert_equal "Reign FC", @@stat_tracker.best_offense
  end

    # League Statistics method
  def test_it_gets_worst_offense
    assert_equal "Utah Royals FC", @@stat_tracker.worst_offense
  end

    # League Statistics method
  def test_it_gets_highest_scoring_visitor
    assert_equal "FC Dallas", @@stat_tracker.highest_scoring_visitor
  end

    # League Statistics method
  def test_it_gets_highest_scoring_home_team
    assert_equal "Reign FC", @@stat_tracker.highest_scoring_home_team
  end

    # League Statistics method
  def test_lowest_score
    average_visitor_scores = @@stat_tracker.average_visitor_scores
    assert_equal "San Jose Earthquakes", @@stat_tracker.lowest_score(average_visitor_scores)
  end

    # League Statistics method
  def test_it_gets_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @@stat_tracker.lowest_scoring_visitor
  end

    # League Statistics method
  def test_it_gets_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @@stat_tracker.lowest_scoring_home_team
  end

    # Team Statistics HELPER method
  def test_it_gets_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_equal expected, @@stat_tracker.team_info("18")
  end

  def test_it_gets_best_season

    assert_equal "20132014", @@stat_tracker.best_season("6")
  end

  def test_it_gets_worst_season

    assert_equal "20142015", @@stat_tracker.worst_season("6")
  end

  def test_it_gets_average_win_percentage

    assert_equal 0.49, @@stat_tracker.average_win_percentage("6")
  end

  def test_it_gets_most_goals_scored

    assert_equal 7, @@stat_tracker.most_goals_scored("18")
  end

  def test_it_gets_fewest_goals_scored

    assert_equal 0, @@stat_tracker.fewest_goals_scored("18")
  end

    # Team Statistics method
  def test_it_gets_favorite_opponent
    assert_equal "DC United", @@stat_tracker.favorite_opponent("18")
  end

    # Team Statistics HELPER method
  def test_all_opponents_stats
    assert_equal 513, @@stat_tracker.all_opponents_stats("18").count
    all_opponent = @@stat_tracker.all_opponents_stats("18").none? do |stat|
      stat.team_id == "18"
    end
    assert_equal true, all_opponent
  end

    # Team Statistics HELPER method
  def test_win_percentage_against
    expected = {
      "19"=>0.44,
      "52"=>0.45,
      "21"=>0.38,
      "20"=>0.39,
      "17"=>0.64,
      "29"=>0.40,
      "25"=>0.37,
      "16"=>0.37,
      "30"=>0.41,
      "1"=>0.40,
      "8"=>0.30,
      "23"=>0.39,
      "3"=>0.30,
      "14"=>0.00,
      "15"=>0.50,
      "28"=>0.44,
      "22"=>0.22,
      "24"=>0.26,
      "5"=>0.56,
      "2"=>0.40,
      "26"=>0.44,
      "7"=>0.30,
      "27"=>0.33,
      "6"=>0.30,
      "13"=>0.6,
      "10"=>0.5,
      "9"=>0.20,
      "12"=>0.4,
      "54"=>0.33,
      "4"=>0.20,
      "53"=>0.25
    }
    assert_equal expected, @@stat_tracker.win_percentage_against("18")
  end

    # Team Statistics method
  def test_it_gets_rival
    expected = ["Houston Dash", "LA Galaxy"]
    assert_includes expected, @@stat_tracker.rival("18")
  end

# Team Statistics Helper Method # FINISH THIS!
  def test_it_can_find_win_percentage
    skip

    team_games_by_id = stat_tracker.all_games_by_team("6")
    assert_equal 0.54, @@stat_tracker.win_percentage(team_games_by_id)
  end

# Team Statistics Helper Method # FINISH THIS!
  def test_it_can_find_all_games_played_by_a_team

    assert_equal 510, @@stat_tracker.all_games_by_team("6").count
  end


  def test_it_gets_winningest_coach
    assert_equal "Claude Julien", @@stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @@stat_tracker.winningest_coach("20142015")
  end

  def test_it_gets_worst_coach
    assert_equal "Peter Laviolette", @@stat_tracker.worst_coach("20132014")
    expected = ["Craig MacTavish", "Ted Nolan"]
    assert_includes expected, @@stat_tracker.worst_coach("20142015")
  end

  #Season Module HELPER METHOD
  def test_it_gets_results_by_head_coach
    @@stat_tracker.expects(:game_ids_in_season).returns([2014030411, 2014030412])
    expected = {
      "Joel Quenneville" => ["WIN", "WIN"],
      "Jon Cooper"=>["LOSS", "LOSS"]
    }
    assert_equal expected, @@stat_tracker.results_by_head_coach("20132014")
  end

  #Season Module HELPER METHOD
  def test_it_gets_game_ids_in_season
    assert_equal 1319, @@stat_tracker.game_ids_in_season("20142015").count
    assert_equal true, @@stat_tracker.game_ids_in_season("20142015").count == @@stat_tracker.game_ids_in_season("20142015").uniq.count

  end

  def test_it_gets_most_accurate_team
    assert_equal "Real Salt Lake", @@stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @@stat_tracker.most_accurate_team("20142015")
  end

  def test_it_gets_least_accurate_team
    assert_equal "New York City FC", @@stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @@stat_tracker.least_accurate_team("20142015")
  end

  def test_it_gets_most_tackles
    assert_equal "FC Cincinnati", @@stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @@stat_tracker.most_tackles("20142015")
  end

  def test_it_gets_fewest_tackles
    assert_equal "Atlanta United", @@stat_tracker.fewest_tackles("20132014") # FAIL
    assert_equal "Orlando City SC", @@stat_tracker.fewest_tackles("20142015") # FAIL
  end

  # Team stats helper method
  def test_it_gets_tackles_by_team
    expected = {16=>1836, 19=>2087, 30=>1787, 21=>2223, 26=>3691, 24=>2515, 25=>1820, 23=>1710, 4=>2404, 17=>1783, 29=>2915, 15=>1904, 20=>1708, 18=>1611, 6=>2441, 8=>2211, 5=>2510, 2=>2092, 52=>2313, 14=>1774, 13=>1860, 28=>1931, 7=>1992, 10=>2592, 27=>2173, 1=>1568, 9=>2351, 22=>1751, 3=>2675, 12=>1807}
    assert_equal expected, @@stat_tracker.tackles_by_team("20132014")
  end

  def test_it_gets_goals_and_shots_by_team
    expected = {16=>[237.0, 779.0], 19=>[193.0, 620.0], 30=>[184.0, 606.0], 21=>[193.0, 613.0], 26=>[232.0, 819.0], 24=>[232.0, 693.0], 25=>[199.0, 663.0], 23=>[161.0, 604.0], 4=>[185.0, 633.0], 17=>[177.0, 615.0], 29=>[188.0, 626.0], 15=>[161.0, 571.0], 20=>[164.0, 518.0], 18=>[166.0, 565.0], 6=>[220.0, 718.0], 8=>[198.0, 667.0], 5=>[209.0, 688.0], 2=>[178.0, 604.0], 52=>[175.0, 595.0], 14=>[188.0, 611.0], 13=>[154.0, 583.0], 28=>[203.0, 741.0], 7=>[136.0, 507.0], 10=>[170.0, 543.0], 27=>[172.0, 595.0], 1=>[157.0, 513.0], 9=>[171.0, 648.0], 22=>[155.0, 520.0], 3=>[222.0, 822.0], 12=>[167.0, 611.0]}
    assert_equal expected, @@stat_tracker.goals_and_shots_by_team("20132014")
  end
end
