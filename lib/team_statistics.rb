require_relative "./stat_tracker"
require "csv"

class TeamStatistics < StatTracker

  def season_home_team_calcs
    season_wins = 0
    season_losses = 0
    season_ties = 0
    CSV.foreach(@games, :headers=>true, :header_converters=>:symbol) do |row|
      if row[:home_goals].to_i > row[:away_goals].to_i
        season_wins += 1
      elsif row[:home_goals].to_i < row[:away_goals].to_i
        season_losses += 1
      else season_ties += 1
      end
    end
  end
end
