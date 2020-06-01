module GameStatistics

  def highest_total_score
    @games.reduce([]) do |scores, game|
      scores << game.away_goals + game.home_goals
      scores
    end.max
  end

  def lowest_total_score
    @games.reduce([]) do |scores, game|
      scores << game.away_goals + game.home_goals
      scores
    end.min
  end

  def all_total_scores
    @games.reduce([]) do |scores, game|
      scores << game.away_goals + game.home_goals
      scores
    end
  end

  # def percentage_home_wins
  #   home_wins = 0
  #   CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
  #     home_wins += 1 if row[:hoa] == "home" && row[:result] == "WIN"
  #   end
  #   (home_wins/total_games_played * 100).round(2)
  # end
  #
  # def percentage_visitor_wins
  #   away_wins = 0
  #   CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
  #     away_wins += 1 if row[:hoa] == "away" && row[:result] == "WIN"
  #   end
  #   (away_wins/total_games_played * 100).round(2)
  # end
  #
  # def total_games_played
  #   total_games = CSV.read(@games, :headers=>true)
  #   total_games.count.to_f
  # end
  #
  # def percentage_ties
  #   ties = 0
  #   CSV.foreach(@game_teams, :headers=>true, :header_converters=>:symbol) do |row|
  #     ties += 1 if row[:result] == "TIE"
  #   end
  #   (ties / 2 / total_games_played * 100).round(2)
  # end

end
