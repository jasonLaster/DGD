

module Sql

  # BULK_INSERT generalizes the process for building bulk inserts in sql from active record arrays of the same model
  # It works by abstrating the model from the data, getting the table name and columns,
  # and then getting the row data from the active record objects.
  def self.bulk_insert(data, opts={})

    # VALUES
    model = data.first.class
    table_name = model.table_name
    columns = model.column_names.delete_if {|c| %w{id created_at updated_at}.include?(c)}
    rows = data.to_column_values.map {|r| r.sql_stringify(:quotes => true)}

    sql =
      "
      INSERT INTO #{table_name}
        #{columns.sql_stringify}
      VALUES
        #{rows.join(", ")}
      "

    # OUTPUT
    format = opts[:format] || :data
    return (format == :sql) ? sql : ActiveRecord::Base.connection.execute(sql)

  end


  # INSERT_INTO accepts a sql query and db table and inserts the result of the
  # sql query into the db table.
  def self.insert_into(query, table_name, opts={})

    sql =
      "
      INSERT INTO #{table_name}
      #{query}
      "

    # OUTPUT
    format = opts[:format] || :data
    return (format == :sql) ? sql : ActiveRecord::Base.connection.execute(sql)

  end


  # ASSIGN BINDINGS breaks a query into sql and an array of params, formats the params
  # and then inserts the params into the sql using ActiveRecords sanitize_sql method
  def self.assign_bindings(query)

    # QUERY AND PARAMS
    query, *params = query

    # SUPPORT ARRAY AND DATE PARAMS
    params.map! do |param|
      if param.class == Array
        param.sql_stringify
      elsif param.class == String && param.is_date?
        param
      else
        param
      end
    end

    # ASSIGN BINDINGS
    q = [query] + params
    sql = ActiveRecord::Base.__send__(:sanitize_sql, q, '')

    # FORMAT SQL
    sql = sql.gsub(/(\s*\n){2,}/, "\n\n").strip # remove whitespace
    sql = sql.gsub(/^\s+/,"")
    sql


  end


  # EXECUTE takes a sql query and returns the results of the query
  def self.execute(query, opts={})

    # GET SQL AND CONNECTION
    sql = assign_bindings(query)
    connection = ActiveRecord::Base.connection

    # EXECUTE QUERY
    puts sql if opts[:print_sql].present? && opts[:print_sql]
    return sql if opts[:format].present? && opts[:format] == :query
    results = connection.execute sql

    # FORMAT OUTPUT
    results.map! {|row| row.delete_if {|k,v| k.class == Fixnum}} #remove duplicate data
    row = results.shift
    columns, rows = row.keys, [row.values]
    results.each {|row| rows << row.values}
    return [columns, rows]
  end

end
