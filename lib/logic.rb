# rubocop: disable Metrics/CyclomaticComplexity
require_relative 'error'

class Logic
  def initialize
    @win_cases = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @board_choices = []
    @player1_choices = []
    @player2_choices = []
    @moves = 0
    @error_message = ''
  end

  def check_move(move, player)
    valid_move = true

    move = move.to_i
    if @board_choices.include?(move)
      @error_message = Error::INVALID_NUMBERS_SAME
    else
      @moves += 1
      @board_choices.push(move)
      player == 1 ? @player1_choices.push(move) : @player2_choices.push(move)
    end

    valid_move
  end

  def check_input(move, player)
    valid_input = false

    case move
    when /^[1-9]$/
      valid_input = check_move(move, player)
    when /\s/
      @error_message = Error::INVALID_NUMBERS_EMPTY
    when /^\d\.\d+/
      @error_message = Error::INVALID_NUMBERS_FLOATS
    when /^\-?\d+\.?\d*$/
      @error_message = Error::INVALID_NUMBERS_RANGE
    when /^[A-Za-z]/
      @error_message = Error::INVALID_NUMBERS_LETTER
    when /^[^A-Za-z0-9]/
      @error_message = Error::INVALID_NUMBERS_SYMBOL
    else
      @error_message = Error::INVALID_NUMBERS_EMPTY
    end

    valid_input
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

  def valid_name(name, oldname)
    is_valid_name = false
    if name.empty?
      @error_message = Error::INVALID_NAME_EMPTY
    elsif name.length > 10
      @error_message = Error::INVALID_NAME_TOO_LONG
    elsif name == oldname
      @error_message = Error::INVALID_NAME_SAME
    else
      is_valid_name = true
    end
    is_valid_name
  end
end

# rubocop: enable Metrics/CyclomaticComplexity
