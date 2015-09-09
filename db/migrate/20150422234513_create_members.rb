class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.integer :group_id, null: false
      t.integer :team_id, null: false

      t.timestamps
    end
  end
end
