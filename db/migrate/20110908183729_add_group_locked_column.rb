class AddGroupLockedColumn < ActiveRecord::Migration
  def change
    add_column :groups, :locked, :boolean, :default => false
  end
end
