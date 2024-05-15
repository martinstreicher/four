require 'rails_helper'

RSpec.describe WinningConditionService do
  subject(:service) do
    described_class.new(board: board, player: player, position: position)
  end

  let(:board) { Board.from_grid(grid) }

  let(:grid) do
    [
      %w[0 0 0 0 0 0 0],
      %w[0 0 0 0 0 0 0],
      %w[0 0 0 0 0 0 0],
      %w[0 0 0 0 0 0 0],
      %w[0 0 0 0 0 0 0],
      %w[0 0 0 0 0 0 0]
    ]
  end

  let(:position) { { row: 5, column: 0 } }
  let(:player)   { 'X' }

  describe 'when looking for horizontal winning conditions' do
    context 'when there is a horizontal win' do
      let(:grid) do
        super().tap do |g|
          g[5] = %w[0 0 0 X X X X]
        end
      end

      it 'returns true' do
        expect(service).to be_won
      end
    end

    context 'when there is not a horizontal win' do
      let(:grid) do
        super().tap do |g|
          g[5] = %w[0 0 0 X X 0 0]
        end
      end

      it 'returns false' do
        expect(service).not_to be_won
      end
    end
  end

  describe 'when looking for vertical winning conditions' do
    context 'when there is a vertical win' do
      let(:grid) do
        super().tap do |g|
          g[0][5] = 'X'
          g[0][4] = 'X'
          g[0][3] = 'X'
          g[0][2] = 'X'
        end
      end

      let(:position) { { row: 2, column: 0 } }

      it 'returns true' do
        expect(service).to be_won
      end
    end
  end
end
