class AddGroupLockedColumn < ActiveRecord::Migration
  def change
    add_column :groups, :locked, :boolean
  end
end
