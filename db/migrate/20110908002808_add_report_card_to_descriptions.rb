class AddReportCardToDescriptions < ActiveRecord::Migration
  def change
    add_column :descriptions, :exec_list, :binary
    add_column :descriptions, :description, :binary
    add_column :descriptions, :contact_information, :binary
    add_column :descriptions, :events, :binary
  end
end
