class Board
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_board
    counter = 0
    board = ''
    [1, 2, 3].each do
      board += '-' * 11 + "\n" unless counter.zero?
      [1, 2, 3].each do
        counter += 1
        board += " #{@board[counter - 1]} " if (counter % 3).zero?
        board += " #{@board[counter - 1]} |" unless (counter % 3).zero?
      end
      board += "\n"
    end
    board
  end

  def update_board(move, sym)
    @board[move - 1] = sym
    show_board
  end
end
