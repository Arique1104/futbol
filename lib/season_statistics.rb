module SeasonStatistics


  def winningest_coach(season)

    game_ids_in_season =  @games.reduce([]) do |acc, game|
      if game.season == season
        acc << game.game_id
      end
      acc
    end

    results_by_head_coach = @game_teams.reduce(Hash.new {|hash, key| hash[key] = []}) do |acc, game_team|
      if game_ids_in_season.include?(game_team.game_id)
        acc[game_team.head_coach] << game_team.result
      end
      acc
    end

    winningest_coach = results_by_head_coach.max_by do |coach, results|
      results_by_head_coach[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first

  end

  def worst_coach(season)
    game_ids_in_season =  @games.reduce([]) do |acc, game|
      if game.season == season
        acc << game.game_id
      end
      acc
    end

    results_by_head_coach = @game_teams.reduce(Hash.new {|hash, key| hash[key] = []}) do |acc, game_team|
      if game_ids_in_season.include?(game_team.game_id)
        acc[game_team.head_coach] << game_team.result
      end
      acc
    end

    worst_coach = results_by_head_coach.min_by do |coach, results|
      results_by_head_coach[coach] = (results.count {|x| x == "WIN"}) / results.count.to_f
    end.first
  end

end
