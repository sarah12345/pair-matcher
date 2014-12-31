class GroupsController < ApplicationController
  before_action :authenticate_user!, :verify_user_requested

  def create
    group = current_user.groups.build(group_params)
    errors = group.save ? [] : group.errors.full_messages
    render json: {errors: errors}.to_json
  end

  private

  def verify_user_requested
    render json: {errors: ['Unauthorized user']} unless current_user.to_param == params[:user_id]
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
