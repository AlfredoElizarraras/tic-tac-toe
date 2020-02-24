#!/usr/bin/env ruby
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

def game_start
  board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  puts 'Welcome to Tic-tac-toe'
  print "\n"
  show_board(board)
  print "\n"

  count = 0

  while count < 3
    print 'Player 1 turn, please enter a number: '
    p1_move = gets.chomp.to_i
    print "\n"
    update_board(p1_move, board, 'X')
    print "\n"
    print 'Player 2 turn, please enter a number: '
    p2_move = gets.chomp.to_i
    print "\n"
    update_board(p2_move, board, 'O')
    print "\n"
    count += 1
  end
  puts 'Game over!'
end

game_start
# puts "Welcome to Tic-tac-toe!"
# (1..3).each do |n|
#   puts "It's Player 1 turn. Please enter a number: "
#   p1_move = gets.chomp!
#   puts "The board gets updated to show player 1 move"
#   puts "It's Player 2 turn. Please enter a number: "
#   p2_move = gets.chomp!
#   puts "The board gets updated to show player 2 move"
# end
# puts "Player 1 won. Game Over"
