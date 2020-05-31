module TeamStatistics

  def win_percentage(team_games) #calculate win percentage
    wins = 0.0
    team_games.each do |game|
      wins += 1.0 if game.result == "WIN"
    end
    (wins / team_games.length)
  end

  def best_season(team_id) # compare team_id to home and away team id to find team seasons
    team_seasons = @games.find_all do |game|
      game.home_team_id  == team_id || game.away_team_id == team_id
    end

    games_in_season = team_seasons.group_by do |game| # group games that match the team id into one season
      game.season
    end

    games_in_season.each do |season, season_games| # for each season, find all the season game ids
    season_game_ids = season_games.map do |game|
      game.game_id
      end

      team_games = @game_teams.find_all do |game|
        # find all the games where the team id (the team_id argument, the one we are searching out)
        # is equal to the team id inside of each game in the season.
        # TLDR: Checks to make sure the team id we gave matches the team ids in the given season
        game.team_id == team_id && season_game_ids.include?(game.game_id) # boolean check
      end
      games_in_season[season] = win_percentage(team_games) # find the win percent of season
    end
    games_in_season.max_by do |season, win_percentage| # find the season with the highest win percentage
     win_percentage
    end[0]
  end
end
