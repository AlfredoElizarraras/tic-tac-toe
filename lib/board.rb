class Board
  
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_board
    counter = 0
    [1, 2, 3].each do
      print '-' * 11, "\n" unless counter.zero?
      [1, 2, 3].each do
        counter += 1
        if (counter % 3).zero?
          print " #{@board[counter - 1]} "
        else
          print " #{@board[counter - 1]} |"
        end
      end
      puts "\n"
    end
  end
  
  def update_board(move, sym)
    @board[move - 1] = sym
    show_board
  end
end