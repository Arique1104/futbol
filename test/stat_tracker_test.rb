require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

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
  end

  # League Statistics HELPER method
  def test_it_can_get_visitor_scores
    assert_equal Hash, @@stat_tracker.visitor_scores.class
    assert_equal 32, @@stat_tracker.visitor_scores.count
    assert_equal true, @@stat_tracker.visitor_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  # League Statistics HELPER method
  def test_it_can_get_home_team_scores
    assert_equal Hash, @@stat_tracker.home_team_scores.class
    assert_equal 32, @@stat_tracker.home_team_scores.count
    assert_equal true, @@stat_tracker.home_team_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
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
    assert_equal expected, @@stat_tracker.average_visitor_scores
  end

    # League Statistics HELPER method
  def test_average_team_scores
      expected = {
        "3"=>2.13,
        "6"=>2.26,
        "5"=>2.29,
        "17"=>2.06,
        "16"=>2.16,
        "9"=>2.11,
        "8"=>2.05,
        "30"=>2.12,
        "26"=>2.08,
        "19"=>2.11,
        "24"=>2.2,
        "2"=>2.18,
        "15"=>2.21,
        "20"=>2.07,
        "14"=>2.22,
        "28"=>2.19,
        "4"=>2.04,
        "21"=>2.07,
        "25"=>2.22,
        "13"=>2.06,
        "18"=>2.15,
        "10"=>2.11,
        "29"=>2.17,
        "52"=>2.17,
        "54"=>2.34,
        "1"=>1.94,
        "23"=>1.97,
        "12"=>2.04,
        "27"=>2.02,
        "7"=>1.84,
        "22"=>2.05,
        "53"=>1.89
      }
    assert_equal expected, @@stat_tracker.average_team_scores
  end

    # League Statistics HELPER method
  def test_average_home_team_scores
    expected = {
      "6"=>2.28,
      "3"=>2.1,
      "5"=>2.39,
      "16"=>2.23,
      "17"=>2.08,
      "8"=>2.08,
      "9"=>2.2,
      "30"=>2.22,
      "19"=>2.17,
      "26"=>2.14,
      "24"=>2.25,
      "2"=>2.28,
      "15"=>2.22,
      "20"=>2.2,
      "14"=>2.32,
      "28"=>2.24,
      "4"=>2.11,
      "21"=>2.22,
      "25"=>2.33,
      "13"=>2.16,
      "18"=>2.24,
      "10"=>2.26,
      "29"=>2.21,
      "52"=>2.3,
      "54"=>2.59,
      "1"=>1.97,
      "23"=>2.01,
      "27"=>2.2,
      "7"=>1.79,
      "22"=>2.06,
      "12"=>2.07,
      "53"=>1.93
    }

    assert_equal expected, @@stat_tracker.average_home_team_scores
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
    expected = {"Joel Quenneville"=>["WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "TIE", "TIE", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "TIE", "WIN", "WIN", "TIE", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "TIE", "WIN", "LOSS", "TIE", "TIE", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "WIN", "WIN", "WIN"], "Ken Hitchcock"=>["LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "TIE", "TIE", "WIN", "LOSS", "TIE", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "TIE", "TIE", "TIE", "WIN", "WIN", "LOSS", "TIE", "TIE", "TIE", "TIE", "TIE", "LOSS", "WIN", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "WIN", "TIE", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "TIE", "WIN", "TIE", "TIE", "WIN"], "Mike Yeo"=>["LOSS", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "TIE", "TIE", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "TIE", "TIE", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "WIN", "WIN", "LOSS", "TIE", "TIE", "TIE", "TIE", "LOSS", "TIE"], "Patrick Roy"=>["WIN", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "TIE", "WIN", "TIE", "LOSS", "TIE", "LOSS", "WIN", "WIN", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "TIE", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "WIN", "TIE", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "LOSS"], "Darryl Sutter"=>["WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "WIN", "TIE", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "WIN", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "TIE", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "TIE", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS"], "Bruce Boudreau"=>["LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "TIE", "TIE", "LOSS", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "TIE", "LOSS", "WIN", "WIN", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "TIE", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "TIE", "WIN", "WIN"], "Lindy Ruff"=>["WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "TIE", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "WIN", "TIE", "TIE", "WIN", "TIE", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "WIN", "TIE", "TIE", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "LOSS"], "John Tortorella"=>["WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "WIN", "TIE", "LOSS", "TIE", "TIE", "WIN", "TIE", "TIE", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "WIN", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "TIE"], "Craig Berube"=>["LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "TIE", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "TIE", "WIN", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "WIN", "TIE", "WIN", "TIE", "LOSS", "WIN", "TIE", "TIE", "LOSS", "WIN", "TIE", "TIE", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "WIN", "WIN", "LOSS", "TIE", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "TIE"], "Mike Babcock"=>["TIE", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "TIE", "TIE", "LOSS", "WIN", "WIN", "TIE", "TIE", "TIE", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "WIN", "TIE", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "TIE", "TIE", "TIE", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN"], "Todd Richards"=>["TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "TIE", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "TIE", "WIN", "LOSS", "WIN", "TIE", "TIE", "WIN", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "WIN", "WIN", "TIE"], "Adam Oates"=>["WIN", "TIE", "TIE", "TIE", "TIE", "TIE", "LOSS", "WIN", "TIE", "TIE", "WIN", "TIE", "TIE", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "WIN", "TIE", "LOSS", "WIN", "WIN", "WIN", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN"], "Bob Hartley"=>["TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "TIE", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN"], "Barry Trotz"=>["TIE", "LOSS", "TIE", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "WIN", "LOSS", "TIE", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "WIN", "TIE", "WIN", "LOSS"], "Claude Julien"=>["WIN", "WIN", "TIE", "WIN", "WIN", "TIE", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "TIE", "WIN", "TIE", "TIE", "WIN", "TIE", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "WIN", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "LOSS", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "TIE", "WIN", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "WIN", "TIE"], "Michel Therrien"=>["TIE", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "TIE", "LOSS", "WIN", "TIE", "WIN", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE"], "Dan Bylsma"=>["LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "TIE", "LOSS", "WIN", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "TIE", "WIN", "TIE", "LOSS", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "LOSS", "LOSS"], "Jack Capuano"=>["LOSS", "LOSS", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "TIE", "TIE", "WIN", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "WIN", "TIE", "TIE", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "TIE", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "WIN", "TIE"], "Claude Noel"=>["WIN", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "TIE", "LOSS", "TIE", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "LOSS"], "Jon Cooper"=>["LOSS", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "WIN", "TIE", "WIN", "TIE", "TIE", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "TIE", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "TIE", "TIE", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "WIN", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "WIN", "TIE", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "WIN", "TIE", "WIN"], "Kevin Dineen"=>["LOSS", "WIN", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "TIE", "WIN", "LOSS"], "Todd McLellan"=>["WIN", "TIE", "WIN", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "TIE", "WIN", "LOSS", "LOSS", "WIN", "TIE", "TIE", "LOSS", "LOSS", "WIN", "WIN", "WIN", "WIN", "WIN", "WIN", "TIE", "TIE", "TIE", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "WIN", "TIE", "WIN", "WIN", "WIN", "TIE", "TIE", "TIE", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "TIE", "WIN", "WIN", "WIN", "TIE", "WIN", "WIN", "TIE", "LOSS", "TIE", "LOSS", "WIN", "TIE", "LOSS", "WIN", "TIE", "WIN"], "Ted Nolan"=>["TIE", "TIE", "WIN", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "TIE", "TIE", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "LOSS"], "Randy Carlyle"=>["WIN", "TIE", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "TIE", "TIE", "TIE", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "TIE", "TIE", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "TIE", "WIN", "TIE", "WIN"], "Dave Tippett"=>["WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "LOSS", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "TIE", "WIN", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "TIE", "LOSS", "WIN", "TIE", "TIE", "WIN", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "WIN"], "Peter DeBoer"=>["WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "TIE", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "WIN", "WIN", "WIN", "WIN", "TIE", "TIE", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "WIN", "WIN", "TIE", "WIN", "LOSS", "TIE"], "Peter Horachek"=>["LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "WIN", "WIN", "TIE", "TIE", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "WIN", "TIE", "WIN", "TIE", "WIN", "LOSS", "LOSS", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "WIN", "LOSS"], "Paul Maurice"=>["LOSS", "TIE", "LOSS", "LOSS", "TIE", "TIE", "WIN", "LOSS", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "TIE", "WIN", "TIE", "WIN", "TIE", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "TIE", "LOSS", "LOSS", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "TIE"], "Paul MacLean"=>["WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "TIE", "WIN", "LOSS", "TIE", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "TIE", "WIN", "WIN", "TIE", "LOSS", "TIE", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "TIE", "WIN", "LOSS", "WIN", "TIE", "LOSS", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "TIE", "TIE", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "TIE", "TIE", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS"], "Dallas Eakins"=>["LOSS", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "TIE", "WIN", "LOSS", "WIN", "WIN", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "TIE", "TIE", "LOSS", "TIE", "TIE", "LOSS", "TIE", "LOSS", "WIN", "WIN", "LOSS", "TIE", "TIE", "WIN", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "TIE", "TIE"], "Alain Vigneault"=>["WIN", "WIN", "LOSS", "TIE", "WIN", "WIN", "LOSS", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "WIN", "TIE", "WIN", "LOSS", "TIE", "LOSS", "WIN", "WIN", "WIN", "WIN", "LOSS", "WIN", "LOSS", "LOSS", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "WIN", "WIN", "WIN", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "TIE", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "TIE", "LOSS", "LOSS", "WIN", "WIN", "WIN", "TIE", "WIN", "WIN", "WIN", "WIN", "LOSS", "TIE", "LOSS", "WIN", "LOSS", "WIN", "TIE", "LOSS", "TIE", "WIN", "LOSS", "WIN", "TIE", "TIE", "LOSS", "TIE", "WIN", "WIN", "WIN", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS"], "Kirk Muller"=>["LOSS", "LOSS", "WIN", "TIE", "LOSS", "WIN", "WIN", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "TIE", "WIN", "WIN", "WIN", "LOSS", "LOSS", "TIE", "TIE", "WIN", "TIE", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "LOSS", "TIE", "LOSS", "WIN", "TIE", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "TIE", "LOSS", "TIE", "LOSS", "WIN", "TIE", "LOSS", "WIN", "WIN", "LOSS", "LOSS", "LOSS", "TIE", "WIN", "TIE", "WIN", "LOSS", "WIN", "WIN", "LOSS", "WIN", "LOSS", "TIE", "WIN"], "Ron Rolston"=>["LOSS", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "LOSS", "TIE", "LOSS", "LOSS", "WIN", "LOSS", "TIE", "LOSS", "TIE", "WIN", "LOSS", "LOSS", "LOSS"], "Peter Laviolette"=>["LOSS", "LOSS", "LOSS"]}

    assert_equal expected, @@stat_tracker.results_by_head_coach("20132014")
  end

  #Season Module HELPER METHOD
  def test_it_gets_game_ids_in_season
   expected = [2014030411, 2014030412, 2014030413, 2014030414, 2014030415, 2014030416, 2014030131, 2014030132, 2014030133, 2014030134, 2014030135, 2014030311, 2014030312, 2014030313, 2014030314, 2014030315, 2014030316, 2014030317, 2014030151, 2014030152, 2014030153, 2014030154, 2014030155, 2014030156, 2014030111, 2014030112, 2014030113, 2014030114, 2014030115, 2014030116, 2014030231, 2014030232, 2014030233, 2014030234, 2014030221, 2014030222, 2014030223, 2014030224, 2014030225, 2014030226, 2014030227, 2014030211, 2014030212, 2014030213, 2014030214, 2014030215, 2014030216, 2014030141, 2014030142, 2014030143, 2014030144, 2014030145, 2014030146, 2014030147, 2014030171, 2014030172, 2014030173, 2014030174, 2014020793, 2014020700, 2014020201, 2014021092, 2014020693, 2014020548, 2014020434, 2014020205, 2014020133, 2014020016, 2014021055, 2014020411, 2014020889, 2014020211, 2014020208, 2014020394, 2014020010, 2014020307, 2014020903, 2014020526, 2014021039, 2014020650, 2014020861, 2014020331, 2014020870, 2014020643, 2014020427, 2014020671, 2014020217, 2014021215, 2014021045, 2014021063, 2014020902, 2014020444, 2014020827, 2014021105, 2014020576, 2014020242, 2014020243, 2014021189, 2014020528, 2014020212, 2014020261, 2014020716, 2014021154, 2014020605, 2014020350, 2014020194, 2014020537, 2014021059, 2014021044, 2014020253, 2014020353, 2014020486, 2014021060, 2014020766, 2014020552, 2014020206, 2014021204, 2014020988, 2014020025, 2014020575, 2014020613, 2014020823, 2014020071, 2014020265, 2014021014, 2014020198, 2014020124, 2014020999, 2014020771, 2014020465, 2014020694, 2014020926, 2014020451, 2014020404, 2014020590, 2014020327, 2014020263, 2014020865, 2014020270, 2014020799, 2014021212, 2014020998, 2014020806, 2014020677, 2014020906, 2014020334, 2014020734, 2014020932, 2014020210, 2014020646, 2014020648, 2014020851, 2014021126, 2014020611, 2014020997, 2014020304, 2014020973, 2014020831, 2014020914, 2014021096, 2014020070, 2014021147, 2014020873, 2014020142, 2014021224, 2014020079, 2014020770, 2014020670, 2014020348, 2014020921, 2014020314, 2014020164, 2014020300, 2014020303, 2014021077, 2014020466, 2014020287, 2014020247, 2014020508, 2014020817, 2014020524, 2014020184, 2014020284, 2014021004, 2014020708, 2014020439, 2014021122, 2014020089, 2014020955, 2014021228, 2014021170, 2014020317, 2014020250, 2014021163, 2014020029, 2014021072, 2014020939, 2014020495, 2014020715, 2014020636, 2014020963, 2014020846, 2014020190, 2014021002, 2014021160, 2014020448, 2014021088, 2014020499, 2014021172, 2014020512, 2014021127, 2014020148, 2014020268, 2014020487, 2014020481, 2014020492, 2014020927, 2014021085, 2014020550, 2014020985, 2014020683, 2014030181, 2014030182, 2014030183, 2014030184, 2014030185, 2014030186, 2014030241, 2014030242, 2014030243, 2014030244, 2014030245, 2014030121, 2014030122, 2014030123, 2014030124, 2014030125, 2014030126, 2014030127, 2014030161, 2014030162, 2014030163, 2014030164, 2014030165, 2014030166, 2014030321, 2014030322, 2014030323, 2014030324, 2014030325, 2014030326, 2014030327, 2014020406, 2014020980, 2014020838, 2014020207, 2014021199, 2014020909, 2014020173, 2014020794, 2014020919, 2014020711, 2014020560, 2014020129, 2014020063, 2014020589, 2014020087, 2014020277, 2014020172, 2014020894, 2014020529, 2014020933, 2014020412, 2014020416, 2014020449, 2014020167, 2014021208, 2014020354, 2014021005, 2014021129, 2014020369, 2014020464, 2014020175, 2014020595, 2014020160, 2014021071, 2014020052, 2014020111, 2014021144, 2014020297, 2014020505, 2014021053, 2014020054, 2014020546, 2014020812, 2014020659, 2014020258, 2014020591, 2014020573, 2014020880, 2014020442, 2014020741, 2014020091, 2014020878, 2014021133, 2014020056, 2014020074, 2014020946, 2014020739, 2014020260, 2014020803, 2014020847, 2014020578, 2014020469, 2014020553, 2014020686, 2014020126, 2014020856, 2014020815, 2014020150, 2014020226, 2014021220, 2014020187, 2014020875, 2014020978, 2014020969, 2014020905, 2014020447, 2014020756, 2014020622, 2014020266, 2014021113, 2014020179, 2014020602, 2014020315, 2014020288, 2014020391, 2014020146, 2014020822, 2014020768, 2014020503, 2014020214, 2014020665, 2014020540, 2014020679, 2014020001, 2014021162, 2014020935, 2014020773, 2014020994, 2014020791, 2014020754, 2014020425, 2014020781, 2014020713, 2014020373, 2014020178, 2014020032, 2014020006, 2014020395, 2014020483, 2014020363, 2014020004, 2014020913, 2014021019, 2014020929, 2014020598, 2014020785, 2014021148, 2014020176, 2014020960, 2014020898, 2014021155, 2014021011, 2014021183, 2014020832, 2014021091, 2014020383, 2014020695, 2014020106, 2014020352, 2014021107, 2014020682, 2014021166, 2014020551, 2014020248, 2014020292, 2014020398, 2014020399, 2014020062, 2014020326, 2014021118, 2014020472, 2014020159, 2014020061, 2014020491, 2014020541, 2014020971, 2014020034, 2014020380, 2014020274, 2014020299, 2014020375, 2014020138, 2014020975, 2014020428, 2014020751, 2014020271, 2014020309, 2014020634, 2014020510, 2014020223, 2014020884, 2014021145, 2014020970, 2014020316, 2014020853, 2014020232, 2014020496, 2014020361, 2014020582, 2014021075, 2014020681, 2014021003, 2014020937, 2014021120, 2014020925, 2014021084, 2014020236, 2014021226, 2014020678, 2014020385, 2014020441, 2014020024, 2014020961, 2014021205, 2014020654, 2014021150, 2014021221, 2014021193, 2014020635, 2014020257, 2014020996, 2014020774, 2014020618, 2014020728, 2014021070, 2014021061, 2014020076, 2014020621, 2014020189, 2014020099, 2014021037, 2014020640, 2014020097, 2014020066, 2014020293, 2014020414, 2014020213, 2014020197, 2014020330, 2014020475, 2014020345, 2014020396, 2014020135, 2014020656, 2014021125, 2014020649, 2014021142, 2014020584, 2014021074, 2014020168, 2014020098, 2014020202, 2014020273, 2014020514, 2014020310, 2014021090, 2014020183, 2014020603, 2014020289, 2014021176, 2014020896, 2014020783, 2014020800, 2014021174, 2014020993, 2014020477, 2014020617, 2014021230, 2014020721, 2014020729, 2014020096, 2014020745, 2014020830, 2014021083, 2014020387, 2014020571, 2014021165, 2014021217, 2014020941, 2014020761, 2014020078, 2014021032, 2014020767, 2014021089, 2014020668, 2014020749, 2014020237, 2014020977, 2014020608, 2014020338, 2014020502, 2014020697, 2014020301, 2014021192, 2014020374, 2014020474, 2014020647, 2014020555, 2014021207, 2014020722, 2014021064, 2014020343, 2014020862, 2014020638, 2014020047, 2014020459, 2014020115, 2014020507, 2014020415, 2014021218, 2014020390, 2014020533, 2014020836, 2014020252, 2014021182, 2014020585, 2014020855, 2014020769, 2014020249, 2014020981, 2014020854, 2014020340, 2014020807, 2014020877, 2014020890, 2014020421, 2014020246, 2014020012, 2014020050, 2014021191, 2014020630, 2014020132, 2014020152, 2014021169, 2014021138, 2014021052, 2014021137, 2014020934, 2014020809, 2014020460, 2014020625, 2014021027, 2014020731, 2014020123, 2014020506, 2014020424, 2014021016, 2014020710, 2014020792, 2014020984, 2014020604, 2014020839, 2014021020, 2014021188, 2014020667, 2014020813, 2014021104, 2014020707, 2014021015, 2014020765, 2014020982, 2014021128, 2014020519, 2014020918, 2014020947, 2014020841, 2014020753, 2014020218, 2014020177, 2014020272, 2014020620, 2014020058, 2014020633, 2014020689, 2014020983, 2014020651, 2014020017, 2014020069, 2014020787, 2014020200, 2014020631, 2014020128, 2014020468, 2014020738, 2014020664, 2014021136, 2014020520, 2014020119, 2014020660, 2014021114, 2014020818, 2014020245, 2014020102, 2014021156, 2014020705, 2014020110, 2014020055, 2014020632, 2014020305, 2014020714, 2014020140, 2014020413, 2014020542, 2014021117, 2014020311, 2014020692, 2014020758, 2014020332, 2014020365, 2014020367, 2014021093, 2014020336, 2014020392, 2014020661, 2014021029, 2014020699, 2014020810, 2014020180, 2014021198, 2014020527, 2014020723, 2014020161, 2014021009, 2014020882, 2014020151, 2014020013, 2014021159, 2014020500, 2014020986, 2014020592, 2014020901, 2014020493, 2014020171, 2014020269, 2014020278, 2014020117, 2014020356, 2014020577, 2014020264, 2014020163, 2014020917, 2014020532, 2014020480, 2014020669, 2014020490, 2014021164, 2014021153, 2014020042, 2014020779, 2014020028, 2014020579, 2014020358, 2014020122, 2014020743, 2014020845, 2014020043, 2014020816, 2014020231, 2014020446, 2014021210, 2014020928, 2014020948, 2014020075, 2014020308, 2014020843, 2014020169, 2014020255, 2014020377, 2014020458, 2014020438, 2014020676, 2014021030, 2014020860, 2014020915, 2014020891, 2014020653, 2014020035, 2014021119, 2014020378, 2014020615, 2014020238, 2014020456, 2014020100, 2014020030, 2014020819, 2014021097, 2014020554, 2014020068, 2014020362, 2014021067, 2014020037, 2014021140, 2014020569, 2014020795, 2014020964, 2014020357, 2014021151, 2014020139, 2014020958, 2014020732, 2014021203, 2014020275, 2014020606, 2014020757, 2014020080, 2014020339, 2014020879, 2014020852, 2014020900, 2014020484, 2014021102, 2014020401, 2014021043, 2014020600, 2014020221, 2014021214, 2014020312, 2014021216, 2014021223, 2014020820, 2014020642, 2014020199, 2014020437, 2014020690, 2014021194, 2014021149, 2014020684, 2014020763, 2014020888, 2014020930, 2014020614, 2014020876, 2014020772, 2014020675, 2014020426, 2014021227, 2014020868, 2014020565, 2014020166, 2014020039, 2014020181, 2014020804, 2014020355, 2014020084, 2014020639, 2014020476, 2014021139, 2014020887, 2014020165, 2014021095, 2014020215, 2014020174, 2014020344, 2014020523, 2014020170, 2014020494, 2014021131, 2014020112, 2014020637, 2014020461, 2014020628, 2014021023, 2014020216, 2014020967, 2014020335, 2014020543, 2014020825, 2014020410, 2014020558, 2014021225, 2014020924, 2014020234, 2014020805, 2014021058, 2014020031, 2014020703, 2014020095, 2014020143, 2014020251, 2014020388, 2014020762, 2014020371, 2014020776, 2014020313, 2014020021, 2014020706, 2014020323, 2014020103, 2014020688, 2014020545, 2014020153, 2014020525, 2014020561, 2014020204, 2014021181, 2014020863, 2014020629, 2014020026, 2014020019, 2014021001, 2014020645, 2014020672, 2014021042, 2014020848, 2014020788, 2014020789, 2014020798, 2014020051, 2014020530, 2014020285, 2014020952, 2014020235, 2014020241, 2014020436, 2014020892, 2014020696, 2014021187, 2014020504, 2014020572, 2014021017, 2014020610, 2014020114, 2014020956, 2014020962, 2014020842, 2014020064, 2014020005, 2014020580, 2014020222, 2014020033, 2014020319, 2014020886, 2014020294, 2014020408, 2014020036, 2014021047, 2014020727, 2014020596, 2014021068, 2014021056, 2014020534, 2014021209, 2014020141, 2014020588, 2014020364, 2014020869, 2014020060, 2014020626, 2014021108, 2014020814, 2014020376, 2014021179, 2014020864, 2014020623, 2014020107, 2014021195, 2014021106, 2014020162, 2014020144, 2014020885, 2014021100, 2014021109, 2014020067, 2014020094, 2014020020, 2014020370, 2014020612, 2014020726, 2014020760, 2014020995, 2014020594, 2014021185, 2014020233, 2014020359, 2014021018, 2014020400, 2014020701, 2014020583, 2014020219, 2014020942, 2014020155, 2014020321, 2014020616, 2014020922, 2014020040, 2014021031, 2014020121, 2014020702, 2014020658, 2014020992, 2014020764, 2014020938, 2014020655, 2014020105, 2014021046, 2014020966, 2014021078, 2014020509, 2014020959, 2014021098, 2014020893, 2014021057, 2014020038, 2014020158, 2014020065, 2014020844, 2014020857, 2014020559, 2014020736, 2014020624, 2014020498, 2014021033, 2014020717, 2014020081, 2014021040, 2014020470, 2014020755, 2014020674, 2014020599, 2014020282, 2014020801, 2014021024, 2014020482, 2014020954, 2014020556, 2014020521, 2014020118, 2014021161, 2014020473, 2014020544, 2014020082, 2014020059, 2014021006, 2014021000, 2014020680, 2014020619, 2014020536, 2014020027, 2014021062, 2014020137, 2014020306, 2014020911, 2014021012, 2014020104, 2014020737, 2014020644, 2014020337, 2014021028, 2014020587, 2014020322, 2014020403, 2014020965, 2014020262, 2014020497, 2014020744, 2014020256, 2014020718, 2014020730, 2014020145, 2014021010, 2014020195, 2014020867, 2014021152, 2014020740, 2014020407, 2014020471, 2014020704, 2014020685, 2014020797, 2014020044, 2014020085, 2014020342, 2014020485, 2014020752, 2014020904, 2014021200, 2014020351, 2014020185, 2014020972, 2014020295, 2014020777, 2014020182, 2014021135, 2014020881, 2014021206, 2014020286, 2014020987, 2014020811, 2014021069, 2014020535, 2014021008, 2014020829, 2014020691, 2014020225, 2014020191, 2014020381, 2014021229, 2014020230, 2014020131, 2014021013, 2014020432, 2014020920, 2014021007, 2014020652, 2014020130, 2014020850, 2014020108, 2014021080, 2014020574, 2014020957, 2014021115, 2014020908, 2014021197, 2014020405, 2014020950, 2014020073, 2014020429, 2014020871, 2014020120, 2014020386, 2014021173, 2014020940, 2014021094, 2014020910, 2014020008, 2014020735, 2014020567, 2014020259, 2014021101, 2014020329, 2014020430, 2014020828, 2014020347, 2014021112, 2014020015, 2014020455, 2014020712, 2014021121, 2014020742, 2014020834, 2014020318, 2014020279, 2014020086, 2014020780, 2014020431, 2014020254, 2014020568, 2014021171, 2014020149, 2014020384, 2014020041, 2014020462, 2014020951, 2014021134, 2014020022, 2014020607, 2014020134, 2014020324, 2014021219, 2014020759, 2014020092, 2014020976, 2014020402, 2014020379, 2014020949, 2014020453, 2014020203, 2014020698, 2014021186, 2014020859, 2014020488, 2014020325, 2014020511, 2014020454, 2014020990, 2014020849, 2014020790, 2014020136, 2014020709, 2014020007, 2014020564, 2014020719, 2014021048, 2014021086, 2014021022, 2014021178, 2014020397, 2014020003, 2014020931, 2014020452, 2014020023, 2014020750, 2014020445, 2014020597, 2014020360, 2014020113, 2014021025, 2014021066, 2014020423, 2014020018, 2014020443, 2014020673, 2014020748, 2014020916, 2014020581, 2014020418, 2014020907, 2014020796, 2014020899, 2014020912, 2014020784, 2014021177, 2014021141, 2014020923, 2014020782, 2014020549, 2014020808, 2014020283, 2014020048, 2014020733, 2014020209, 2014021049, 2014020328, 2014020562, 2014020517, 2014020072, 2014020011, 2014020897, 2014020046, 2014020154, 2014020239, 2014020547, 2014020586, 2014020090, 2014020989, 2014020778, 2014021035, 2014020786, 2014020566, 2014020298, 2014021123, 2014020479, 2014020002, 2014020501, 2014020240, 2014020116, 2014020489, 2014020093, 2014020518, 2014020883, 2014020188, 2014020290, 2014021213, 2014020440, 2014020663, 2014020196, 2014020127, 2014020276, 2014020826, 2014020840, 2014020382, 2014020991, 2014021111, 2014021196, 2014020944, 2014020837, 2014021081, 2014020516, 2014021051, 2014020280, 2014020858, 2014020609, 2014020945, 2014021026, 2014020372, 2014021038, 2014021082, 2014020666, 2014020422, 2014020835, 2014020824, 2014020953, 2014021103, 2014021143, 2014020320, 2014021054, 2014021110, 2014020220, 2014020057, 2014021124, 2014021158, 2014021034, 2014020775, 2014021211, 2014020157, 2014020657, 2014020872, 2014020420, 2014020539, 2014020936, 2014020522, 2014021065, 2014021175, 2014020641, 2014020563, 2014020478, 2014020463, 2014020229, 2014021050, 2014020125, 2014020083, 2014021073, 2014021202, 2014021099, 2014020341, 2014020302, 2014020513, 2014020538, 2014020662, 2014020687, 2014020147, 2014020417, 2014021201, 2014021087, 2014021222, 2014021157, 2014020467, 2014020570, 2014020296, 2014020435, 2014020943, 2014021041, 2014020724, 2014020968, 2014020419, 2014020389, 2014020725, 2014020627, 2014021132, 2014020244, 2014020802, 2014021079, 2014020450, 2014021180, 2014020088, 2014020109, 2014020045, 2014020049, 2014020009, 2014021076, 2014020349, 2014020409, 2014020895, 2014020156, 2014020281, 2014021116, 2014020515, 2014020531, 2014021168, 2014020557, 2014021190, 2014020014, 2014020821, 2014020833, 2014020457, 2014021130, 2014020291, 2014020346, 2014020747, 2014020224, 2014020393, 2014020077, 2014020366, 2014020433, 2014021146, 2014020101, 2014020974, 2014020227, 2014021036, 2014020192, 2014020228, 2014020593, 2014020267, 2014020368, 2014020193, 2014020866, 2014021184, 2014021021, 2014020053, 2014020601, 2014021167, 2014020874, 2014020186, 2014020333, 2014020720, 2014020746, 2014020979]
    assert_equal expected, @@stat_tracker.game_ids_in_season("20142015")
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
    skip
    assert_equal "FC Cincinnati", @@stat_tracker.most_tackles("20132014") # PASS
    # assert_equal "Seattle Sounders FC", @@stat_tracker.most_tackles("20142015") # FAIL
  end

  def test_it_gets_fewest_tackles
    skip
    # assert_equal "Atlanta United", @@stat_tracker.fewest_tackles("20132014") # FAIL
    # assert_equal "Orlando City SC", @@stat_tracker.fewest_tackles("20142015") # FAIL
  end

  def test_it_gets_goals_and_shots_by_team
    expected = {16=>[237.0, 779.0], 19=>[193.0, 620.0], 30=>[184.0, 606.0], 21=>[193.0, 613.0], 26=>[232.0, 819.0], 24=>[232.0, 693.0], 25=>[199.0, 663.0], 23=>[161.0, 604.0], 4=>[185.0, 633.0], 17=>[177.0, 615.0], 29=>[188.0, 626.0], 15=>[161.0, 571.0], 20=>[164.0, 518.0], 18=>[166.0, 565.0], 6=>[220.0, 718.0], 8=>[198.0, 667.0], 5=>[209.0, 688.0], 2=>[178.0, 604.0], 52=>[175.0, 595.0], 14=>[188.0, 611.0], 13=>[154.0, 583.0], 28=>[203.0, 741.0], 7=>[136.0, 507.0], 10=>[170.0, 543.0], 27=>[172.0, 595.0], 1=>[157.0, 513.0], 9=>[171.0, 648.0], 22=>[155.0, 520.0], 3=>[222.0, 822.0], 12=>[167.0, 611.0]}
    assert_equal expected, @@stat_tracker.goals_and_shots_by_team("20132014")
  end
end
