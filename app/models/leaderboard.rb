
module Leaderboard
  include Sql
    
  def self.query
    sql =
      "
      SELECT
        u.id,
        u.name,
        count(distinct d.group_id) as num_contributions
      FROM descriptions d
      LEFT JOIN users u on u.id = d.user_id
      WHERE d.created_at >= #{(Date.today - 10).to_s(:db)}
      GROUP BY d.user_id
      "
      
    Sql.execute(sql)
  end
  
end