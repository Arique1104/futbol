require_relative './teams'
require_relative './collection'

class TeamsCollection < Collection

  def initialize
    super
    @statistics = Teams
  end

end
