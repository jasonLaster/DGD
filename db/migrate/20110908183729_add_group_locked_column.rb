class AddGroupLockedColumn < ActiveRecord::Migration
  def change
    add_column :groups, :locked, :binary
  end
end
