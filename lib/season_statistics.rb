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

end
