require_relative "./stat_tracker"
require "csv"

class SeasonStatistics < StatTracker

  def most_accurate_team(season)

    games_rows = CSV.read(@games, :headers => true, :header_converters => :symbol)

    game_ids_in_season = games_rows.reduce([]) do |acc, row|
      acc << row[:game_id] if row[:season] == season
      acc
    end

    game_teams_rows = CSV.read(@game_teams, :headers => true, :header_converters => :symbol)

    games_played_in_season = game_teams_rows.find_all do |row|
       game_ids_in_season.include?(row[:game_id])
    end

    games_by_team = games_played_in_season.group_by do |row|
      row[:team_id]
    end

    shots_and_goals_by_team = games_by_team.each do |team, games|
      games_by_team[team] = games.reduce([0,0]) do |acc, stats|
        acc[0] += stats[:goals].to_f
        acc[1] += stats[:shots].to_f
        acc
      end
    end

    accuracy_by_team = shots_and_goals_by_team.each do |team, games|
      games_by_team[team] = (games_by_team[team][0] / games_by_team[team][1])
    end

    most_accurate_team_id = accuracy_by_team.max_by do |team, accuracy|
      accuracy
    end.first

    team_rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)

    team_name = team_rows.find do | row|
      row[:team_id] == most_accurate_team_id
    end[:teamname]

  end

  def least_accurate_team(season)

    games_rows = CSV.read(@games, :headers => true, :header_converters => :symbol)

    game_ids_in_season = games_rows.reduce([]) do |acc, row|
      acc << row[:game_id] if row[:season] == season
      acc
    end

    game_teams_rows = CSV.read(@game_teams, :headers => true, :header_converters => :symbol)

    games_played_in_season = game_teams_rows.find_all do |row|
       game_ids_in_season.include?(row[:game_id])
    end

    games_by_team = games_played_in_season.group_by do |row|
      row[:team_id]
    end

    shots_and_goals_by_team = games_by_team.each do |team, games|
      games_by_team[team] = games.reduce([0,0]) do |acc, stats|
        acc[0] += stats[:goals].to_f
        acc[1] += stats[:shots].to_f
        acc
      end
    end

    accuracy_by_team = shots_and_goals_by_team.each do |team, games|
      games_by_team[team] = (games_by_team[team][0] / games_by_team[team][1])
    end

    least_accurate_team_id = accuracy_by_team.min_by do |team, accuracy|
      accuracy
    end.first

    team_rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)

    team_name = team_rows.find do | row|
      row[:team_id] == least_accurate_team_id
    end[:teamname]


  end

end
