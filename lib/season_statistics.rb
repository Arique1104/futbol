module SeasonStatistics

  def winningest_coach(season)
    coach_results = results_by_head_coach(season)
    winningest_coach = coach_results.max_by do |coach, results|
      coach_results[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first
  end

  def worst_coach(season)
    coach_results = results_by_head_coach(season)
    worst_coach = coach_results.min_by do |coach, results|
      coach_results[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first
  end

  def game_ids_in_season(season)
    @games.reduce([]) do |acc, game|
      acc << game.game_id.to_i if game.season == season
      acc
    end
  end

  def results_by_head_coach(season)
    game_ids = game_ids_in_season(season)
    @game_teams.reduce(Hash.new {|hash, key| hash[key] = []}) do |acc, game_team|
      if game_ids.include?(game_team.game_id.to_i)
        acc[game_team.head_coach] << game_team.result
      end
      acc
    end
  end

  def most_accurate_team(season)
    team_ratios = goals_and_shots_by_team(season)
    most_accurate_team_id = team_ratios.max_by do |team_id, ratio|
      ratio[0] / ratio[1]
    end.first
    @teams.each { |team| return team.teamname if most_accurate_team_id == team.team_id.to_i }
  end

  def least_accurate_team(season)
    team_ratios = goals_and_shots_by_team(season)
    least_accurate_team_id = team_ratios.min_by do |team_id, ratio|
      ratio[0] / ratio[1]
    end.first
    @teams.each { |team| return team.teamname if least_accurate_team_id == team.team_id.to_i }
  end

  def goals_and_shots_by_team(season)
    game_ids = game_ids_in_season(season)
    @game_teams.reduce(Hash.new {|hash, key| hash[key] = [0,0]}) do |acc, game_team|
      if game_ids.include?(game_team.game_id.to_i)
        acc[game_team.team_id.to_i][0] += game_team.goals.to_f
        acc[game_team.team_id.to_i][1] += game_team.shots.to_f
      end
      acc
    end
  end

  def most_tackles(season)
    season_tackles = tackles_by_team(season)
    @teams.find do |team|
      team.team_id.to_i == season_tackles.max_by {|_, tackles| tackles}.first
    end.teamname
  end

  def tackles_by_team(season)
    game_ids = game_ids_in_season(season)
    x = @game_teams.each_with_object(Hash.new(0)) do |game_team, tackles_by_team|
      if game_ids.include?(game_team.game_id.to_i)
        tackles_by_team[game_team.team_id.to_i] += game_team.tackles
      end
    end
  end

  def fewest_tackles(season)
    season_tackles = tackles_by_team(season)
    @teams.find do |team|
      team.team_id.to_i == season_tackles.min_by {|_, tackles| tackles}.first
    end.teamname
  end

end
