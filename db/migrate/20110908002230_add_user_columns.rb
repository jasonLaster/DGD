class AddUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :admin, :binary
    add_column :users, :blocked, :binary
  end
end
