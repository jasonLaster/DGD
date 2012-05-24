class SqlTable
  attr_accessor :limit, :nom_rows, :columns, :rows, :column_widths

  def initialize(data, opts={})

    # GET COLUMNS AND ROWS
    # at this point pretty_print can only handle two formats [cols, rows] && [active record objs]
    if data.first.class == Array && data.length == 2
      @columns = data.first
      @rows = data.second
    elsif data.first.class.respond_to? :column_names
      model = data.first.class
      @columns = model.column_names
      @rows = data.to_column_values
    end

    # SET VARIABLES AND PRINT FIRST N ROWS
    @num_rows = @rows.length
    @limit = opts[:limit] || 25
    @column_widths = @columns.zip(*@rows).map {|col| col.map(&:to_s).map(&:length).max}
    @enum = ([@columns] + @rows).each_slice(@limit)
    print_rows
    return nil
  end

  # PRINT ROWS.
  def print_rows(data=nil)
    rows = (data || @enum.next)
    padding = "   "
    rows.each do |row|
      row.zip(@column_widths).each do |col, cwidth|
        ws = cwidth - col.to_s.length
        ws = ws > 0 ? " "*ws : ""
        print col.to_s + ws + padding
      end
      puts
    end
    return nil
  end

end
