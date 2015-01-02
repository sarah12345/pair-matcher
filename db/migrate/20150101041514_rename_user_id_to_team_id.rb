class RenameUserIdToTeamId < ActiveRecord::Migration
  def change
    rename_column :groups, :user_id, :team_id
  end
end
