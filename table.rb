require 'roo'
require './kolona'

class Table
  include Enumerable

  def initialize(path)
    # @xlsx = Roo::Excelx.new(file_path)
    # @xlsx.default_sheet = @xlsx.sheets.first
    @table = Roo::Spreadsheet.open(path, { :expand_merged_ranges => true })
    @columns = initialize_cols
  end

  # print table
  def print_table
    @table.each_with_index do |row, row_index|
      row.each_with_index do |element, col_index|
        puts "Element at (#{row_index}, #{col_index}): #{element}"
      end
    end
  end

  def get_row(index)
    @table.row(index)
  end

  def initialize_cols
    colums = {}
    headers = @table.row(1)
    headers.each_with_index do |header, index|
      column_values = @table.column(index + 1).drop(1) # Drop the header row
      colums[header] = column_values
    end
    colums
  end

  # metoda za getovanje kolone po imenu
  # def get_col_by_name(colum_name)
  #   column_index = @table.row(1).index(colum_name)
  #
  #   if column_index.nil?
  #     puts "Column '#{colum_name}' not found in the file."
  #     return nil
  #   end
  #
  #   column_values = @table.column(column_index + 1) # Adding 1 to match Excel indexing (which starts from 1)
  #   column_values.shift # Remove the header row from the column values
  #
  #   column_values
  #
  # end

  # pristupamo po vrednosti i imenu
  def [](column_name)
      @columns[column_name]
  end

  def get_cell_value(column_name, index)
    column = @columns[column_name]
    return nil if column.nil?

    column[index]
  end

end
