class AddReportCardToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :exec_list, :boolean, :default => false
    add_column :descriptions, :description_text, :boolean, :default => false
    add_column :descriptions, :contact_information, :boolean, :default => false
    add_column :descriptions, :events, :boolean, :default => false
  end
end
