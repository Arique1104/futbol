require_relative './collection'
require_relative './game_teams'

class GameTeamsCollection < Collection
  attr_reader :statistics

  def initialize
    super
    @statistics = GameTeams
  end
end
