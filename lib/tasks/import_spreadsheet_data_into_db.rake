task :import_spreadsheet_data_into_db  => :environment do
  doc = File.open("public/OTHER/groups_spreadsheet.txt").read
  list = doc.split("\n")
  c = nil
  list.each do |l|
    if l[/^#/]
      c = l.sub(/^#/,'')
      c = Category.create(:category => c)
    else
      Group.create(:category_id => c.id, :name => l)
    end
  end

  puts "done"
end
