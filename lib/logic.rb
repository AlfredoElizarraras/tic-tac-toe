class Logic
  attr_accessor :board_choices, :player1_choices, :player2_choices

  def initialize
    @win_cases = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @board_choices = []
    @player1_choices = []
    @player2_choices = []
  end
  
  def check_move(move, player)
    return false if @board_choices.include?(move)
    @board_choices.push(move)
    player == 1 ? @player1_choices.push(move) : @player2_choices.push(move)
    return true
  end

  def player_won?(player)
    win = false
     false
    index = 0
    in_board = @win_cases.select do |win_case|
      board_choices.include?(win_case)
    end
    unless in_board.empty?
      in_board.each do |choice|
        if player == 1
          return true if (choice - @player1_choices).empty?
        else
          return true if (choice - @player2_choices).empty?
        end
        @win_cases.delete(choice)
        return false
      end
    end
  end

end
