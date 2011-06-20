class AddColsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :two_cols, :boolean
  end
end
