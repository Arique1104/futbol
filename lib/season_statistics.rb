require_relative "./stat_tracker"
require "csv"

class SeasonStatistics < StatTracker

  #  seasons are in games.csv
  # goals and shots are in game_teams.csv
  # the return value is a string that represents the team name
  # given any season id
  # calculate goals divided by shots

  # def team_name(id)
  #   rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)
  #   rows.find do |row|
  #     return row[:teamname] if row[:team_id] == id.to_s
  #   end
  # end




  def most_accurate_team(season)

    games_rows = CSV.read(@games, :headers => true, :header_converters => :symbol)

    #in regular season
    game_ids_in_season = games_rows.reduce([]) do |acc, row|
      acc << row[:game_id] if row[:season] == season #&& row[:type] == "Regular Season"
      acc
    end





    game_teams_rows = CSV.read(@game_teams, :headers => true, :header_converters => :symbol)

    games_played_in_season = game_teams_rows.find_all do |row|
       game_ids_in_season.include?(row[:game_id])
    end

    # name of the team with the best ratio of shots to goals in a season
    # find total goals and shots by a team in season

    # build hash
    # keys are team id
    # values are collection of goals and shots
    # calculate goals and shots in %
    # get team_id with highest %
    # row[:team_id]
    # row[:goals]
    # row[:shots]
    # hash = {row[:team_id] => [0, 0]}
    # hash = {row[:team_id] => [row[:goals], row[:shots]]}
    # hash = {row[:team_id] => accuracy during season}
    # try helper method for accuracy during season


    # every key is the team_id
    # every value is their average

    games_by_team = games_played_in_season.group_by do |row|
      row[:team_id]
    end

    games_by_team.each do |team, rows|
      rows = rows.reduce([0, 0]) do |acc, row|
        acc[0] += row[:goals].to_f
        acc[1] += row[:shots].to_f
        acc
      end
    end
    require "pry"; binding.pry




    # acc[row[:team_id]][0] += row[:goals].to_f
    # acc[row[:team_id]][1] += row[:shots].to_f


    # team_rows = CSV.read(@teams, :headers => true, :header_converters => :symbol)
    #
    # team_name = team_rows.find do | row|
    #   row[:team_id] == most_accurate_team_id
    # end[:teamname]

  end
end
