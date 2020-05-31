module TeamStatistics

  def win_percentage(team_games)
    wins = 0.0
    team_games.each do |game|
      wins += 1.0 if game.result == "WIN"
    end
    (wins / team_games.length)
  end

  def best_season(team_id)
    team_seasons = @games.find_all do |game|
      game.home_team_id  == team_id || game.away_team_id == team_id
    end
  end
end
