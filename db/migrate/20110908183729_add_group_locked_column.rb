class AddGroupLockedColumn < ActiveRecord::Migration
  def up
    add_column :groups, :locked, :binary
  end

  def down
  end
end
