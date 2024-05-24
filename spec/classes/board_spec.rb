require 'rails_helper'

RSpec.describe Board do
  let(:grid) do
    [
      #   0  1  2  3  4  5  6
      %w[00 10 20 30 40 50 60], # row 0
      %w[01 11 21 31 41 51 61],
      %w[02 12 22 32 42 52 62],
      %w[03 13 23 33 43 53 63],
      %w[04 14 24 34 44 54 64],
      %w[05 15 25 35 45 55 65]  # row 5
  ].transpose
  end

  let(:board) { described_class.from_grid(grid) }

  describe 'when using .from_grid to build a board from an array' do
    it 'creates a board from a grid' do
      7.times do |column|
        expect(board.column(column)).to eq(grid.transpose.pluck(column))
      end
    end
  end

  describe 'when using #row' do
    it 'returns the contents of the row' do
      expect(board.row(5)).to eq(%w[05 15 25 35 45 55 65])
    end
  end

  describe 'when using #cell', :aggregate_failures do
    it 'returns the contents of the cell' do
      expect(board.cell(0, 5)).to eq('05')
      expect(board.cell(6, 0)).to eq('60')
    end
  end

  describe 'when using #diagonal' do
    it 'returns the contents of the diagonal around the position' do
      board.diagonals(position: { column: 0, row: 0 })
      # expect(board.diagonal(position: { column: 0, row: 0 })).to eq('00')
      # expect(board.diagonal(position: { column: 6, row: 5 })).to eq('65')
    end
  end
end
