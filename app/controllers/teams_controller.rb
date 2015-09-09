class TeamsController < ApplicationController
  before_action :verify_team_requested

  def match_pairs
    @pairs = PairMatcherService.generate_pairs(current_team.id)
    render :show
  end

  private

  def verify_team_requested
    return if current_team.to_param == params[:id]
    flash[:error] = ["Unauthorized for team #{params[:id]}"]
    redirect_to team_path(current_team)
  end

end
