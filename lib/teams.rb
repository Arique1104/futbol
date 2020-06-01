class Teams
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(teams_params)
    @team_id = teams_params[:team_id]
    @franchise_id = teams_params[:franchiseid]
    @team_name = teams_params[:teamname]
    @abbreviation = teams_params[:abbreviation]
    @stadium = teams_params[:stadium]
    @link = teams_params[:link]
  end
end
