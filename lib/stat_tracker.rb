require_relative "./teams_collection"
require_relative "./games_collection"
require_relative "./game_teams_collection"

require_relative "./game_statistics"
require_relative "./league_statistics"
require_relative "./season_statistics"
require_relative "./team_statistics"

class StatTracker

  include GameStatistics
  include LeagueStatistics
  include SeasonStatistics
  include TeamStatistics

  def initialize
    @games ||= @@games
    @teams ||= @@teams
    @game_teams ||= @@game_teams
  end

  def self.from_csv(locations)
    @@games ||= GamesCollection.from_csv(locations[:games])
    @@teams ||= TeamsCollection.from_csv(locations[:teams])
    @@game_teams ||= GameTeamsCollection.from_csv(locations[:game_teams])
    self.new
  end

end
