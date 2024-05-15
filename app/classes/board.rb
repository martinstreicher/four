# frozen_string_literal: true

##
# Represent the Connect Four board
#
class Board
  DIAGONAL_OFFSETS =
    [
      [+1, +1],
      [-1, +1],
      [+1, -1],
      [-1, -1]
    ].freeze

  def self.from_grid(grid, columns: 7, rows: 6)
    new(columns:, rows:).tap do |board|
      board_manager = BoardManagerService.new(board)

      grid.reverse.each do |row|
        row.each_with_index do |player, column_index|
          board_manager.insert(column: column_index, player: player)
        end
      end
    end
  end

  def initialize(columns: 7, rows: 6)
    @columns = columns
    @rows    = rows
    @grid    = Array.new(columns) { Array.new(rows) }
  end

  def cell(column_number, row_number)
    column(column_number).try(:[], row_number)&.to_s
  end

  def column(index)
    grid[index]
  end

  def column_full?(index)
    column(index).all?(&:present?)
  end

  def diagonals(position:)
    column = position[:column]
    row    = position[:row]

    [].tap do |diags|
      DIAGONAL_OFFSETS.each do |column_direction, row_direction|
        diagonal =
          (0..6).map do |offset|
            column_index = column + (column_direction * offset)
            row_index    = row + (row_direction * offset)

            next if column_index.negative? || column_index >= columns
            next if row_index.negative? || row_index >= rows

            cell(column_index, row_index)
          end
        diags << diagonal.compact
      end
    end
  end

  def row(index)
    grid.map { |column| column[index] }
  end

  private

  attr_reader :columns, :grid, :rows
end
