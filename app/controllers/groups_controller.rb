class GroupsController < ApplicationController
  before_action :authenticate_team!, :verify_team_requested

  def create
    group = Group.new(group_params.merge(team_id: current_team.id))
    if group.save
      flash[:success] = "'#{group.name}' group was created."; flash.keep(:success)
    end
    render json: {errors: group.errors.full_messages}.to_json
  end

  def destroy
    group = Group.find_by(team_id: current_team.id, id: params[:id])
    if group
      flash[:success] = "'#{group.name}' group was deleted." if group.destroy
    else
      flash[:error] = "Requested group for '#{current_team.display_name}' does not exist."
    end
    redirect_to settings_team_path(current_team)
  end

  private

  def verify_team_requested
    return if current_team.to_param == params[:team_id]
    respond_to do |format|
      errors = ["Unauthorized for team #{params[:team_id]}"]
      format.json do
        render json: {errors: errors}
      end
      format.html do
        flash[:error] = errors; redirect_to settings_team_path(current_team)
      end
    end
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
