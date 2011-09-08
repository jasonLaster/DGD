class CreateGroupExecTable < ActiveRecord::Migration
  def change
    create_table :group_exec do |t|
      t.integer :user_id
      t.integer :group_id
    end
    add_index(:group_exec, [:user_id, :group_id], :unique => true, :null => false)    
  end
end
