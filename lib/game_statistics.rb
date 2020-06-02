module GameStatistics

  def highest_total_score
    all_total_scores.max
  end

  def lowest_total_score
    all_total_scores.min
  end

  def all_total_scores
    @games.each_with_object([]) do |game, scores|
      scores << game.away_goals + game.home_goals
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

  def count_of_games_by_season
    games_by_season = @games.group_by { |game| game.season }
    games_by_season.keys.each_with_object({}) do |season, count_of_games|
      count_of_games[season] = games_by_season[season].count
    end
  end

  def average_goals_per_game
    (all_total_scores.sum / all_total_scores.count.to_f).round(2)
  end

  def average_goals_by_season
    games_by_season = @games.group_by { |game| game.season }
    average_goals_by_season = games_by_season.each do |season, games|
      goals_scored = games.collect { |game| (game.away_goals + game.home_goals).to_f }
      average_goals = (goals_scored.sum / goals_scored.count).round(2)
      games_by_season[season] = average_goals
    end
  end

end
