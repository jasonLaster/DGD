class AddIndexToFlag < ActiveRecord::Migration
  def change
    add_index(:flags, [:user_id, :description_id], :unique => true, :null => false)
  end
end
