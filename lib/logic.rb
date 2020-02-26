require_relative 'Error'

class Logic
  attr_reader :error_message

  def initialize
    @win_cases = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @board_choices = []
    @player1_choices = []
    @player2_choices = []
    @moves = 0
    @error_message = ""
  end

  def check_move(move, player)
    valid_move = true

    if !(move.is_a? Integer) || (move < 1 || move > 9)
      valid_move = false
    elsif @board_choices.include?(move)
      valid_move = false
      @error_message = Error::INVALID_NUMBERS_SAME
    else
      @moves += 1
      @board_choices.push(move)
      player == 1 ? @player1_choices.push(move) : @player2_choices.push(move)
    end

    valid_move
  end

  def player_won?(player)
    in_board = @win_cases.select do |win_case|
      (win_case - @board_choices).empty?
    end

    unless in_board.empty?
      in_board.each do |choice|
        if player == 1
          return true if (choice - @player1_choices).empty?
        elsif player == 2
          return true if (choice - @player2_choices).empty?
        end
        @win_cases.delete(choice)
      end
    end
    false
  end

  def tie?
    return true if @moves == 9
  end
end
