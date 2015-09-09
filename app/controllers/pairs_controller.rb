class PairsController < ApplicationController
  before_action :verify_team_requested

  def index
  end

  def match_pairs
    @pairs = PairMatcherService.generate_pairs(current_team.id)
    render :index
  end

  private

  def verify_team_requested
    return if current_team.to_param == params[:team_id]
    flash[:error] = ["Unauthorized for team #{params[:team_id]}"]
    redirect_to team_pairs_path(current_team)
  end

end
