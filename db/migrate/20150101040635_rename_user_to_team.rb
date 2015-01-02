class RenameUserToTeam < ActiveRecord::Migration

  def change
    rename_table :users, :teams
  end
end
