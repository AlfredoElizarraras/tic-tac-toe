class Board

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_board
    counter = 0
    board_string = ''
    [1, 2, 3].each do
      board_string += '-' * 11 + "\n" unless counter.zero?
      [1, 2, 3].each do
        counter += 1
        board_string += " #{@board[counter - 1]} " if (counter % 3).zero?
        board_string += " #{@board[counter - 1]} |" unless (counter % 3).zero?
      end
      board_string += "\n"
    end
    board_string
  end

  def update_board(move, sym)
    @board[move - 1] = sym
    show_board
  end
end
