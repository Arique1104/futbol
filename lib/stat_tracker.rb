require_relative "./game_statistics"
require_relative "./league_statistics"
require_relative "./season_statistics"
require_relative "./team_statistics"

require_relative "./games_collection"
require_relative "./teams_collection"
require_relative "./game_teams_collection"

class StatTracker

  include GameStatistics
  include LeagueStatistics
  include SeasonStatistics
  include TeamStatistics

  def initialize
    @games ||= @@games.collection
    @teams ||= @@teams.collection
    @game_teams ||= @@game_teams.collection
  end

  def self.from_csv(locations)
    @@games ||= GamesCollection.from_csv(locations[:games])
    @@teams ||= TeamsCollection.from_csv(locations[:teams])
    @@game_teams ||= GameTeamsCollection.from_csv(locations[:game_teams])
    self.new
  end

end
