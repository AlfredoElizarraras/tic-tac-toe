#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/logic'

class Main
  attr_reader :board, :logic

  def initialize
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
        print "#{logic.error_message}, try again: "
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
    @board = nil
    @logic = nil
    @player1 = nil
    @player2 = nil
    @board = Board.new
    @logic = Logic.new
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

  def get_player_info(times_call = true)
    puts "What is your name?"
    name = gets.chomp
    while logic.valid_name(name)
      puts logic.error.message
      name = gets.chomp
    end
    mark = times_call == 1 ? "X" : "O"
    @player1 = Player.new(name,mark,1) if times_call
    @player2 = Player.new(name,mark,2) unless times_call
  end
end

Main.new
