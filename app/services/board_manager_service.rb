# frozen_string_literal: true

class BoardManagerService
  IllegalMoveError = Class.new(StandardError)

  def initialize(board)
    @board = board
  end

  def insert(player:, column:)
    raise(IllegalMoveError) if board.column_full?(column)

    target_column      = board.column(column)
    target_column_size = target_column.size

    target_column.reverse.each_with_index do |cell, index|
      next if cell.present?

      cell_position = target_column_size - index - 1
      target_column[cell_position] = player
      return cell_position
    end
  end

  private

  attr_accessor :board
end
