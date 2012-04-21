class AddConfirmToGroupExecs < ActiveRecord::Migration
  def change
    add_column :group_execs, :confirmed, :boolean, :default => false
  end
end
