#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/logic'

class Main
  attr_accessor :board, :logic

  def initialize
    @board = nil
    @logic = nil
    initialize_variables
    instructions
    game_start
  end

  def game_start
    print board.show_board + "\n"
    (1..9).each do |turn|
      player = turn.even? ? 2 : 1
      mark = turn.even? ? 'O' : 'X'
      p_move = player_turn(player)
      until logic.check_move(p_move, player)
        print 'Not a valid number, try again: '
        p_move = gets.chomp.to_i
      end
      print "\n#{board.update_board(p_move, mark)}\n"
      if logic.player_won?(player)
        puts "Player #{player} wins!\n\n"
        break
      end
      if logic.tie?
        print "It's a Tie!\n\n"
        break
      end
    end
    puts 'Game over!'
  end

  def initialize_variables
    self.board = Board.new
    self.logic = Logic.new
  end

  def instructions
    puts 'Welcome to Tic-tac-toe'
    puts 'Select a number to replace with the given mark:'
    puts "Player 1: 'X'"
    puts "Player 1: 'O'"
    puts "\n\n"
  end

  def player_turn(player)
    print "Player #{player} turn, please enter a number: "
    gets.chomp.to_i
  end
end

Main.new
