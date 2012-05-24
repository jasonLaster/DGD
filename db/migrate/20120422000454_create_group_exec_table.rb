class CreateGroupExecTable < ActiveRecord::Migration
  def change
    create_table :group_execs do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :confirmed, :default => false
    end
    add_index(:group_execs, [:user_id, :group_id], :unique => true, :null => false)
  end
end
