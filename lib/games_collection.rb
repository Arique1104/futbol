require_relative './games'
require_relative './collection'

class GamesCollection < Collection

  def initialize
    super
    @statistics = Games
  end

end
