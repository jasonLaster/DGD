class AddUserIdToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :user_id, :integer
  end
end
