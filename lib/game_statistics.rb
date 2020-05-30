require_relative "./stat_tracker"
require "csv"

class GameStatistics < StatTracker
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

  def count_of_games_by_season
    seasons_collection.each_with_object(Hash.new(0)) do |season, hash|
      hash[season] += 1
    end
  end

  def seasons_collection
    seasons_collection = []
    CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
      seasons_collection << row[:season]
    end
    seasons_collection
  end

  def average_goals_per_game
    (all_total_scores.sum.to_f / all_total_scores.size).round(2)
  end

  def average_goals_by_season
    seasons = seasons_collection.uniq
    goals_by_season = seasons.each_with_object(Hash.new(0)) do |season, hash|
      hash[season] = 0
    end
    CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
      sum_goals = row[:away_goals].to_i + row[:home_goals].to_i
      season = row[:season]
      goals_by_season[season] += sum_goals
    end
    goals_by_season.map do |season, goals|
      average = goals.to_f / (count_of_games_by_season[season])
      goals_by_season[season] = average.round(2)
    end
    goals_by_season
  end

end
