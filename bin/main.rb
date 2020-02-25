#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/logic'

def game_start
  board = Board.new
  logic = Logic.new

  print "Welcome to Tic-tac-toe\n\n"

  board.show_board

  print "\n"

  loop do
    print 'Player 1 turn, please enter a number: '
    p1_move = gets.chomp.to_i
    print "\n"
    until logic.check_move(p1_move, 1)
      print 'Not a valid number, try again: '
      p1_move = gets.chomp.to_i
    end
    board.update_board(p1_move, 'X')
    print "\n"
    if logic.player_won?(1)
      puts "Player 1 wins!\n\n"
      break
    end
    if logic.tie?
      print "It's a Tie!\n\n"
      break
    end
    print 'Player 2 turn, please enter a number: '
    p2_move = gets.chomp.to_i
    print "\n"
    until logic.check_move(p2_move, 2)
      print 'Not a valid number, try again: '
      p2_move = gets.chomp.to_i
    end
    board.update_board(p2_move, 'O')
    print "\n"
    if logic.player_won?(2)
      puts "Player 2 wins!\n\n"
      break
    end
  end
  puts 'Game over!'
end

game_start
