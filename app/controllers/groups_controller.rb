class GroupsController < ApplicationController
  before_action :verify_team_requested

  def create
    group = Group.new(group_params.merge(team_id: current_team.id))
    if group.save
      flash.now[:success] = "Group '#{group.name}' was created."
    else
      flash.now[:error] = "Group was not created. #{group.errors.full_messages.join(', ')}."
    end
    render :index
  end

  def destroy
    group = Group.find_by(team_id: current_team.id, id: params[:id])
    if group
      flash.now[:success] = "Group '#{group.name}' was deleted." if group.destroy
    else
      flash.now[:error] = "Requested group for '#{current_team.display_name}' does not exist."
    end
    render :index
  end

  private

  def verify_team_requested
    return if current_team.to_param == params[:team_id]
    flash[:error] = "Unauthorized for team #{params[:team_id]}"
    redirect_to team_groups_path(current_team)
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
