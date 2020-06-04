require_relative "./collection"
require_relative "./teams"

class TeamsCollection < Collection
  attr_reader :statistics

  def initialize
    super
    @statistics = Teams
  end

end
