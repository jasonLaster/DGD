class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :description
  
  def page_table
    
    sql = 
      "
      SELECT
       g.name as 'group',
       d.description as description, 
       count(*) as num_flags
      FROM flags f
      Left join descriptions d on d.id = f.description_id
      Left join groups g on g.id = d.group_id
      WHERE d.group_id= ?
      group by f.description_id
      order by d.group_id
      "
    
  end
  
end
