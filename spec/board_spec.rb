require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:mock_board) { " 1 | 2 | 3 \n-----------\n 4 | 5 | 6 \n-----------\n 7 | 8 | 9 \n" }

  describe '#show_board' do
    it 'returns a string representing a board without any move on it' do
      expect(board.show_board).to eql(mock_board)
    end
  end

  describe '#update_board' do
    it 'updates the board and then calls the show_board method' do
      mock_board[1] = 'X'
      expect(board.update_board(1, 'X')).to eql(mock_board)
    end
  end
end
