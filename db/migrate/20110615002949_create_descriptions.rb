class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.text :description
      t.integer :group_id
      t.timestamps
    end
  end
end
