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

  # given a season find the Name of the Team with the
  # best ratio of shots to goals for the entire season
  def most_accurate_team(season)
    game_ids = game_ids_in_season(season)
    x = @game_teams.reduce(Hash.new {|hash, key| hash[key] = [0,0]}) do |acc, game_team|
      if game_ids.include?(game_team.game_id.to_i)
        acc[game_team.team_id.to_i][0] += game_team.goals.to_f
        acc[game_team.team_id.to_i][1] += game_team.shots.to_f
      end
      acc
    end

    y = x.max_by do |team_id, ratio|
      ratio[0] / ratio[1]
    end.first

    z = @teams.each do |team|
      if team.team_id.to_i == y
        return team.teamname
      end
    end
  end

  def least_accurate_team(season)
    game_ids = game_ids_in_season(season)
    x = @game_teams.reduce(Hash.new {|hash, key| hash[key] = [0,0]}) do |acc, game_team|
      if game_ids.include?(game_team.game_id.to_i)
        acc[game_team.team_id.to_i][0] += game_team.goals.to_f
        acc[game_team.team_id.to_i][1] += game_team.shots.to_f
      end
      acc
    end

    y = x.min_by do |team_id, ratio|
      ratio[0] / ratio[1]
    end.first

    z = @teams.each do |team|
      if team.team_id.to_i == y
        return team.teamname
      end
    end
  end
end
