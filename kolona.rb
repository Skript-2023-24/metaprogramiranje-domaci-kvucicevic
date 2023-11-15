# frozen_string_literal: true

class Kolona
  def initialize(file_path)
    @columns = get_columns_from_excel(file_path)
  end

  def [](column_name)
    @columns[column_name]
  end

  def get_cell_value(column_name, index)
    column = @columns[column_name]
    return nil if column.nil?

    column[index]
  end

end
