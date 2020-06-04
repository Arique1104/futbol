require_relative "./collection"
require_relative "./games"

class GamesCollection < Collection
  attr_reader :statistics

  def initialize
    super
    @statistics = Games
  end

end
