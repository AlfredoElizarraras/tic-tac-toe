#!/usr/bin/env ruby
# rubocop: disable Metrics/MethodLength
@win_cases = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
@board_choices = []
@player1_choices = []
@player2_choices = []
@moves = 0

def show_board(board)
  counter = 0
  [1, 2, 3].each do
    print '-' * 11, "\n" unless counter.zero?
    [1, 2, 3].each do
      counter += 1
      if (counter % 3).zero?
        print " #{board[counter - 1]} "
      else
        print " #{board[counter - 1]} |"
      end
    end
    puts "\n"
  end
end

def update_board(move, board, sym)
  board[move - 1] = sym
  show_board(board)
end

def check_move(move, player)
  valid_move = true

  if !(move.is_a? Integer) || (move < 1 || move > 9)
    valid_move = false
  elsif @board_choices.include?(move)
    valid_move = false
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

def game_start
  board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  turn = 1
  player = 1

  print "Welcome to Tic-tac-toe\n\n"

  show_board(board)

  print "\n"

  loop do
    turn.odd? ? player = 1 : player = 2
    player == 1 ? mark = 'X' : mark = 'O'
    print "Player #{player} turn, please enter a number: "
    p_move = gets.chomp.to_i
    print "\n"
    until check_move(p_move, player)
      print 'Not a valid number, try again: '
      p_move = gets.chomp.to_i
    end
    update_board(p_move, board, mark)
    print "\n"
    if player_won?(player)
      puts "Player #{player} wins!\n\n"
      break
    elsif tie?
      print "It's a Tie!\n\n"
      break
    end
    turn += 1
  end
  puts 'Game over!'
end

game_start
# rubocop: enable Metrics/MethodLength
