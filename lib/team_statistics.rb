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

    games_in_seasons = team_seasons.group_by do |game|
      game.season
    end

    games_in_seasons.each do |season, season_games|
    season_game_ids = season_games.map do |game|
      game.game_id
      end
      require "pry"; binding.pry
    end
  end
end
