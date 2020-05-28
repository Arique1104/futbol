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

  def percentage_ties
    ties = 0
    CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
      ties += 1 if row[:result] == "TIE"
    end
    (ties / 2 / total_games_played * 100).round(2)
  end

  def count_of_teams
    total_games = CSV.read(@teams, :headers=>true)
    total_games.count
  end

  def team_name(id)
    rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)
    rows.find do |row|
      return row[:teamname] if row[:team_id] == id.to_s
    end
  end

  def team_scores
    scores = Hash.new { |hash, key| hash[key] = [] }
    CSV.foreach(@game_teams, :headers => true, :header_converters => :symbol) do |row|
      scores[row[:team_id]] << row[:goals].to_i
    end
    scores
  end

  def average_team_scores
    #use case for a map do???
    average_scores = Hash.new
    team_scores.each do |team, scores|
      average_scores[team] = (scores.sum.to_f / scores.count).round(2)
    end
    average_scores
  end

  def best_offense
    best_offense_stats = average_team_scores.max_by do |team, av_score|
      av_score
    end
    team_name(best_offense_stats[0])
  end

  def
end
