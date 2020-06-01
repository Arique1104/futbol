module GameStatistics

  def highest_total_score
    all_total_scores.max
  end

  def lowest_total_score
    all_total_scores.min
  end

  def all_total_scores
    scores = []
    CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
      scores << row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores
  end

  def percentage_home_wins
    home_wins = 0
    CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
      home_wins += 1 if row[:hoa] == "home" && row[:result] == "WIN"
    end
    (home_wins/total_games_played * 100).round(2)
  end

  def percentage_visitor_wins
    away_wins = 0
    CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
      away_wins += 1 if row[:hoa] == "away" && row[:result] == "WIN"
    end
    (away_wins/total_games_played * 100).round(2)
  end

  def total_games_played
    total_games = CSV.read(@games, :headers=>true)
    total_games.count.to_f
  end

  def percentage_ties
    ties = 0
    CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
      ties += 1 if row[:result] == "TIE"
    end
    (ties / 2 / total_games_played * 100).round(2)
  end

  # # Highest sum of the winning and losing teams’ scores
  # def highest_total_score # Integer
  # end
  #
  # # Lowest sum of the winning and losing teams’ scores
  # def lowest_total_score # Integer
  # end
  #
  # # Percentage of games that a home team has won (rounded to the nearest 100th)
  # def percentage_home_wins # Float
  # end
  #
  # # Percentage of games that a visitor has won (rounded to the nearest 100th)
  # def percentage_visitor_wins # Float
  # end
  #
  # # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  # def percentage_ties # Float
  # end
  #
  # # A hash with season names (e.g. 20122013) as keys and counts of games as values
  # def count_of_games_by_season # Hash
  # end
  #
  # # Average number of goals scored in a game across all seasons
  # # including both home and away goals (rounded to the nearest 100th)
  # def average_goals_per_game # Float
  # end
  #
  # # Average number of goals in a game by season
  # # ie, {"20172018"=>4.44, ... }
  # def average_goals_by_season # Hash
  # end

end
