class AddReportCardToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :exec_list, :boolean
    add_column :descriptions, :description_text, :boolean
    add_column :descriptions, :contact_information, :boolean
    add_column :descriptions, :events, :boolean
  end
end
