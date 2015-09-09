class MembersController < ApplicationController
  before_action :verify_team_requested, :verify_group_requested

  def create
    member = Member.new(
      {group_id: group_params, team_id: current_team.id}.merge(member_params)
    )
    if member.save
      flash.now[:success] = "Member '#{member.first_name}' was created."
    else
      flash.now[:error] = "Member was not created. #{member.errors.full_messages.join(', ')}."
    end
    render "groups/index"
  end

  private

  def verify_team_requested
    return if current_team.to_param == team_params
    flash[:error] = "Unauthorized for team #{team_params}."
    redirect_to team_groups_path(current_team)
  end

  def verify_group_requested
    matching_group = Group.where(id: group_params, team_id: current_team.id).first
    return if matching_group.present?
    flash[:error] = "Group id #{group_params} not found for current team."
    redirect_to team_groups_path(current_team)
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name)
  end

  def group_params
    params.require(:group_id)
  end

  def team_params
    params.require(:team_id)
  end
end
