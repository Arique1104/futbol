module GameStatistics

  def highest_total_score
    all_total_scores.max
  end

  def lowest_total_score
    all_total_scores.min
  end

  def all_total_scores
    @games.reduce([]) do |scores, game|
      scores << game.away_goals + game.home_goals
      scores
    end
  end

  def percentage_home_wins
    total_home_wins = @game_teams.reduce(0) do |acc, game_team|
      acc += 1 if game_team.hoa == "home" && game_team.result == "WIN"
      acc
    end
    get_percentage(total_home_wins)
  end

  def percentage_visitor_wins
    total_away_wins = @game_teams.reduce(0) do |acc, game_team|
      acc += 1 if game_team.hoa == "away" && game_team.result == "WIN"
      acc
    end
    get_percentage(total_away_wins)
  end

  def percentage_ties
    total_ties = @game_teams.reduce(0) do |acc, game_team|
      acc += 1 if game_team.result == "TIE"
      acc
    end / 2
    get_percentage(total_ties)
  end

  def get_percentage(number_of_games)
    all_games = @games.count.to_f
    (number_of_games / all_games).round(2)
  end

end
