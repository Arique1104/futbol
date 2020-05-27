require "csv"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(file_paths)
    @games = file_paths[:games]
    @teams = file_paths[:teams]
    @game_teams = file_paths[:game_teams]
  end

  def self.from_csv(file_path_locations)
    self.new(file_path_locations)
  end

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
end
