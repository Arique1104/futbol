module TeamStatistics

  def team_info(team_id)
    @teams.reduce({}) do |info, team|
      if team_id == team.team_id
        info["team_id"] = team.team_id
        info["franchise_id"] = team.franchiseid
        info["team_name"] = team.teamname
        info["abbreviation"] = team.abbreviation
        info["link"] = team.link
      end
      info
    end
  end

  def all_opponents_stats(team_id)
    game_ids = all_games_by_team(team_id).map do |game|
      game.game_id
    end
    opponent_stats = []
    @game_teams.each do |game_team|
      opponent_stats << game_team if (game_ids.include?(game_team.game_id) && game_team.team_id != team_id)
    end
    opponent_stats
  end

  def win_percentage_against(team_id)
    grouped_by_team = all_opponents_stats(team_id).group_by do |stat|
      stat.team_id
    end
    win_percent = {}
    grouped_by_team.each do |team_id, games|
      loss = 0
      percent = 0
      games.each do |game|
        loss += 1 if game.result == "WIN"
      end
      win_percent[team_id] = percent += (loss.to_f/games.count).round(2)
    end
    win_percent
  end

  def favorite_opponent(team_id)
    opponent = win_percentage_against(team_id).min_by do |team_id, percent|
      percent
    end[0]
    team_name(opponent)
  end

  def rival(team_id)
    opponent = win_percentage_against(team_id).max_by do |team_id, percent|
      percent
    end[0]
    team_name(opponent)
  end

  def win_percentage(team_games_by_id) #calculate win percentage
    wins = 0.0
    team_games_by_id.each do |game|
      wins += 1.0 if game.result == "WIN"
    end
    (wins / team_games_by_id.length)
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

  def worst_season(team_id)
    team_seasons = @games.find_all do |game|
      game.home_team_id  == team_id || game.away_team_id == team_id
    end

    games_in_season = team_seasons.group_by do |game|
      game.season
    end

    games_in_season.each do |season, season_games|
    season_game_ids = season_games.map do |game|
      game.game_id
      end

      team_games = @game_teams.find_all do |game|
        game.team_id == team_id && season_game_ids.include?(game.game_id)
      end
      games_in_season[season] = win_percentage(team_games)
    end
    games_in_season.min_by do |season, win_percentage| #find the season with the worst win percentage
     win_percentage
    end[0]
  end

  def all_games_by_team(team_id) # find all games that match team id
    @game_teams.find_all do |all_games|
      all_games.team_id == team_id
    end
  end

  def average_win_percentage(team_id)
    all_games = all_games_by_team(team_id)
    win_percentage(all_games).round(2)
  end

  def most_goals_scored(team_id)
    all_games_by_team(team_id).max_by do |game|
      game.goals
    end.goals
  end

  def fewest_goals_scored(team_id)
    all_games_by_team(team_id).min_by do |game|
      game.goals
    end.goals
  end

  def team_name(id)
    @teams.find do |team|
      return team.teamname if team.team_id == id
    end
  end

end
