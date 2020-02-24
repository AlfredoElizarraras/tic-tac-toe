#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/logic'

def game_start
  board = Board.new
  logic = Logic.new

  puts 'Welcome to Tic-tac-toe'
  print "\n"
  board.show_board
  print "\n"

  count = 0

  while true
    print 'Player 1 turn, please enter a number: '
    p1_move = gets.chomp.to_i
    print "\n"
    while !(logic.check_move(p1_move,1))
      puts "Choose another place, that one has already been taken."
      p1_move = gets.chomp.to_i
    end
    board.update_board(p1_move, 'X')
    if logic.player_won?(1)
      puts "player 1 win"
      break
    end
    print "\n"
    print 'Player 2 turn, please enter a number: '
    p2_move = gets.chomp.to_i
    print "\n"
    while !(logic.check_move(p2_move,2))
      puts "Choose another place, that one has already been taken."
      p2_move = gets.chomp.to_i
    end
    board.update_board(p2_move, 'O')
    if logic.player_won?(2)
      puts "player 2 win"
      break
    end
    print "\n"
    count += 1
  end
  puts 'Game over!'
end

game_start
