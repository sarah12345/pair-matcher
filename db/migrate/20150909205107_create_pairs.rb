class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :member1_id, null: false
      t.integer :member2_id
      t.timestamps
    end
  end
end
