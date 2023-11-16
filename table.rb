require 'roo'
require 'C:\Users\kajav\RubymineProjects\ruby-domaci-katarinavucicevic\metaprogramiranje-domaci-kvucicevic\column.rb'

class Table
  include Enumerable

  def initialize(path)
    # @xlsx = Roo::Excelx.new(file_path)
    # @xlsx.default_sheet = @xlsx.sheets.first
    @table = Roo::Spreadsheet.open(path, { :expand_merged_ranges => true })
    @columns = initialize_cols
    @path = path

    define_column_methods
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
    columns = {}
    headers = @table.row(1)
    headers.each_with_index do |header, index|
      column_values = @table.column(index + 1).drop(1)
                        .reject(&:nil?)
                        .map { |value| value.to_s =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ ? value.to_i : 0 }

      columns[header.downcase.gsub(/\s+/, '')] = column_values unless column_values.empty?
    end
    columns
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

  # pristupamo po vrednosti i imenu, bilo ranije
  # def [](column_name)
  #     @columns[column_name]
  # end
  def [](column_name)
    Column.new(self, column_name, initialize_cols)
  end

  def get_cell_value(column_name, index)
    column = @columns[column_name]
    return nil if column.nil?

    column[index]
  end

  # Biblioteka omogućava podešavanje vrednosti unutar ćelije po sledećoj sintaksi t[“Prva Kolona”][1]= 2556
  def set_cell_value(column_name, index, value)
    column = @columns[column_name]
    return nil if column.nil?

    column[index] = value
    update_excel_file(column_name, index + 2, value) # Add 2 to the index for Excel's 1-based indexing
  end

  def update_excel_file(column_name, row_index, value) # negde je greska, ne znam gde :/
    col_index = @table.row(1).index(column_name) + 1 # Adding 1 to match Excel indexing (which starts from 1)
    @table.set(row_index, col_index, value)

    @table.to_stream.to_file(@path)
  end

  def []=(column_name, index, value)
    set_cell_value(column_name, index, value)
  end

  # woking with columns
  def method_missing(method_name, *args, &block)
    column_name = method_name.to_s.downcase
    return @columns[column_name] if @columns.key?(column_name)

    super
  end

  def respond_to_missing?(method_name, include_private = false)
    @columns.key?(method_name.to_s.downcase) || super
  end

  def define_column_methods
    @columns.each_key do |column_name|
      define_singleton_method(column_name) do
        @columns[column_name]
      end

      define_singleton_method("#{column_name}_sum") do
        @columns[column_name].map(&:to_i).sum
      end

      define_singleton_method("#{column_name}_average") do
        @columns[column_name].map(&:to_i).average
      end
    end
  end

end
