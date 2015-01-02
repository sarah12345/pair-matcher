class GroupsController < ApplicationController
  before_action :authenticate_user!, :verify_user_requested

  def create
    group = Group.new(group_params.merge(user_id: current_user.id))
    if group.save
      flash[:success] = "'#{group.name}' group was created."; flash.keep(:success)
    end
    render json: {errors: group.errors.full_messages}.to_json
  end

  def destroy
    group = Group.find_by(user_id: current_user.id, id: params[:id])
    if group
      flash[:success] = "'#{group.name}' group was deleted." if group.destroy
    else
      flash[:error] = "Requested group for '#{current_user.display_name}' does not exist."
    end
    redirect_to settings_user_path(current_user)
  end

  private

  def verify_user_requested
    return if current_user.to_param == params[:user_id]
    respond_to do |format|
      errors = ["Unauthorized for user #{params[:user_id]}"]
      format.json do
        render json: {errors: errors}
      end
      format.html do
        flash[:error] = errors; redirect_to settings_user_path(current_user)
      end
    end
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
