# frozen_string_literal: true

class WinningConditionService
  def initialize(board:, player:, position:)
    @board    = board
    @position = position
    @player   = player
  end

  def won?
    horizontal? || vertical? || diagonal?
  end

  private

  ## Top left of game board is 0,0
  #
  def diagonal?
    board.diagonals(position:).any? do |diagonal|
      diagonal.join.include?(player * 4)
    end
  end

  def horizontal?
    row = board.row(position[:row])

    row[position[:column]..].join.include?(player * 4) ||
      row[0..position[:column]].join.include?(player * 4)
  end

  def vertical?
    column = board.column(position[:column])

    column[position[:row]..].join.include?(player * 4) ||
      column[..position[:row]].join.include?(player * 4)
  end

  attr_reader :board, :player, :position
end
