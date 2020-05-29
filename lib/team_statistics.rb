require_relative "./stat_tracker"
require "csv"

class TeamStatistics < StatTracker


# I need some way of keeping the wins or losses count to only stay within a specific season
  def home_or_away_team_id(id)
    rows = CSV.foreach(@games, :headers => true, :header_converters => :symbol)
    rows.find_all do |row|
      if row[:away_team_id] || row[:home_team_id] == id.to_s
        return true
      end
    end
  end

  # need to pass in home id to get percent for given team
  # what is the best way to pass in that id?
  # need to make season_away_team

  def season_home_team_wins
  season_wins = 0
  CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
    if row[:home_goals].to_i > row[:away_goals].to_i
      season_wins += 1
    end
  end
end


  # def season_home_team_calcs
  #   season_wins = 0
  #   season_losses = 0
  #   season_ties = 0
  #   CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
  #     if row[:home_goals].to_i > row[:away_goals].to_i
  #       season_wins += 1
  #     elsif row[:home_goals].to_i < row[:away_goals].to_i
  #       season_losses += 1
  #     else season_ties += 1
  #     end
  #   end
  # end
