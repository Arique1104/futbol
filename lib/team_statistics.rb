module TeamStatistics

  def team_info(team_id)
    @teams.each_with_object({}) do |team, info|
      next unless team_id == team.team_id

      info['team_id'] = team.team_id
      info['franchise_id'] = team.franchiseid
      info['team_name'] = team.teamname
      info['abbreviation'] = team.abbreviation
      info['link'] = team.link
    end
  end

  def all_opponents_stats(team_id)
    game_ids = all_games_by_team(team_id).map(&:game_id)
    opponent_stats = []
    @game_teams.each do |game_team|
      if game_ids.include?(game_team.game_id) && game_team.team_id != team_id
        opponent_stats << game_team
      end
    end
    opponent_stats
  end

  def win_percentage_against(team_id)
    grouped_by_team = all_opponents_stats(team_id).group_by(&:team_id)
    win_percent = {}
    grouped_by_team.each do |team_id, games|
      loss = 0
      percent = 0
      games.each { |game| loss += 1 if game.result == 'WIN' }
      win_percent[team_id] = percent += (loss.to_f / games.count).round(2)
    end
    win_percent
  end

  def favorite_opponent(team_id)
    opponent = win_percentage_against(team_id).min_by { |_team_id, percent| percent }.first
    team_name(opponent)
  end

  def rival(team_id)
    opponent = win_percentage_against(team_id).max_by { |_team_id, percent| percent }.first
    team_name(opponent)
  end

  def win_percentage(team_games_by_id)
    wins = 0.0
    team_games_by_id.each { |game| wins += 1.0 if game.result == 'WIN' }
    (wins / team_games_by_id.length)
  end

  def find_team_games_by_id(team_id) #Write a test
    @games.find_all do |game|
      game.home_team_id  == team_id || game.away_team_id == team_id
    end
  end

  def games_in_season(team_id) # hash of season keys and game object values
    find_team_games_by_id(team_id).group_by(&:season)
  end

  def best_season(team_id)
    percentage_by_season = Hash.new
    games_in_season(team_id).each do |season, season_games|
      season_game_ids = season_games.map(&:game_id)
      team_games_in_season_by_id = @game_teams.find_all do |game|
        game.team_id == team_id && season_game_ids.include?(game.game_id)
      end
      percentage_by_season[season] = win_percentage(team_games_in_season_by_id)
    end
    percentage_by_season.max_by { |_, win_percentage| win_percentage }.first
  end

  def worst_season(team_id)
    percentage_by_season = Hash.new
    games_in_season(team_id).each do |season, season_games|
      season_game_ids = season_games.map(&:game_id)
      team_games_in_season_by_id = @game_teams.find_all do |game|
        game.team_id == team_id && season_game_ids.include?(game.game_id)
      end
      percentage_by_season[season] = win_percentage(team_games_in_season_by_id)
    end
    percentage_by_season.min_by { |_, win_percentage| win_percentage }.first
  end

  def all_games_by_team(team_id)
    @game_teams.find_all { |all_games| all_games.team_id == team_id }
  end

  def average_win_percentage(team_id)
    all_games = all_games_by_team(team_id)
    win_percentage(all_games).round(2)
  end

  def most_goals_scored(team_id)
    all_games_by_team(team_id).max_by(&:goals).goals
  end

  def fewest_goals_scored(team_id)
    all_games_by_team(team_id).min_by(&:goals).goals
  end

  def team_name(id)
    @teams.find do |team|
      return team.teamname if team.team_id == id
    end
  end
end
