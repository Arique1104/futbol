module SeasonStatistics


  def winningest_coach(season)
    game_ids = game_ids_in_season(season)
    results_by_head_coach = @game_teams.reduce(Hash.new {|hash, key| hash[key] = []}) do |acc, game_team|
      acc[game_team.head_coach] << game_team.result if game_ids.include?(game_team.game_id.to_i)
      acc
    end

    winningest_coach = results_by_head_coach.max_by do |coach, results|
      results_by_head_coach[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first

  end

  def worst_coach(season)
    game_ids = game_ids_in_season(season)
    results_by_head_coach = @game_teams.reduce(Hash.new {|hash, key| hash[key] = []}) do |acc, game_team|
      acc[game_team.head_coach] << game_team.result if game_ids.include?(game_team.game_id.to_i)
      acc
    end

    worst_coach = results_by_head_coach.min_by do |coach, results|
      results_by_head_coach[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first
  end

  def game_ids_in_season(season)
    @games.reduce([]) do |acc, game|
      acc << game.game_id.to_i if game.season == season
      acc
    end
  end

end
