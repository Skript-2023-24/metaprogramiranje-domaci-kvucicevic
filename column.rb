# frozen_string_literal: true

class Column
  def initialize(table, column_name, values)
    @table = table
    @column_name = column_name
    @values = values
  end

  # def [](index)
  #   @table.get_cell_value(@column_name, index)
  # end overriden by method in 28th line

  def []=(index, value)
    @table.set_cell_value(@column_name, index, value)
  end

  def sum
    @values.map(&:to_i).sum
  end

  def average
    return 0 if @values.empty?

    @values.map(&:to_i).sum / @values.size.to_f
  end

  def avg
    numeric_values = @values.select { |value| value.is_a?(Numeric) }
    return 0 if numeric_values.empty?

    numeric_values.sum / numeric_values.size.to_f
  end
  # def avg
  #   return 0 if @values.empty?
  #
  #   # @values.map(&:to_i).average
  #
  #   @values.map(&:to_i).sum / @values.size.to_f
  # end

  def [](value)
    index = @values.find_index(value.to_s)
    return nil if index.nil?

    index + 2 # Adding 2 to match Excel's 1-based indexing
  end

  def method_missing(method_name, *args, &block)
    value = method_name.to_s
    if @values.include?(value)
      index = @values.find_index(value)
      return nil if index.nil?

      index + 2 # Adding 2 to match Excel's 1-based indexing
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @values.include?(method_name.to_s) || super
  end

end
