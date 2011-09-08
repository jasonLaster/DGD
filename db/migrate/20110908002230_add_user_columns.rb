class AddUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :blocked, :boolean, :default => false
  end
end
