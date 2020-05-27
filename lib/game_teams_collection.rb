require "CSV"

class GameTeamsCollection
#attr_reader
@@file_name = "./fixtures/game_teams_fixture.csv"



 def initialize(data)
  @game_id = data["game_id"]
  @team_id = data["team_id"]
  @result = data["result"]
  @coach = data["head_coach"]
  @goals = data["goals"]
  @shots = data["shots"]

 end

end
