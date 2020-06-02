require_relative './game_teams'
require_relative './collection'

class GameTeamsCollection < Collection

  def initialize
    super
    @statistics = GameTeams
  end

end
