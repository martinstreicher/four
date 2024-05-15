require 'rails_helper'

RSpec.describe BoardManagerService do
  context 'when inserting into an empty column' do
    let(:board) { Board.new }

    it 'inserts into the proper place' do
      board_manager = described_class.new(board)
      board_manager.insert(player: 'X', column: 0)

      expect(board.column(0).last).to eq('X')
    end

    it 'inserts in reverse row order' do
      board_manager = described_class.new(board)
      board_manager.insert(player: 'X', column: 0)
      board_manager.insert(player: 'Y', column: 0)

      expect(board.column(0)[-2..-1]).to eq(%w[Y X])
    end
  end

  context 'when trying to insert into a full column' do
    let(:board) do
      Board.new.tap do |board|
        board_manager = described_class.new(board)

        6.times do
          board_manager.insert(player: 'X', column: 0)
        end
      end
    end

    it 'rejects the insert' do
      board_manager = described_class.new(board)

      expect { board_manager.insert(player: 'X', column: 0) }.to(
        raise_exception(described_class::IllegalMoveError)
      )
    end
  end
end
