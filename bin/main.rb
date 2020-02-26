#!/usr/bin/env ruby
require_relative '../lib/board'
require_relative '../lib/logic'
require_relative '../lib/player'

class Main
  attr_reader :board, :logic

  def initialize
    initialize_variables
    instructions
    assign_names(true)
    assign_names(false)
    game_start
  end

  def game_start
    print board.show_board + "\n"
    (1..9).each do |turn|
      player = turn.even? ? @player2 : @player1
      p_move = player_turn(player)
      until logic.check_move(p_move, player.player_number)
        print "#{logic.error_message}, try again: "
        p_move = gets.chomp
      end
      print "\n#{board.update_board(p_move, player.mark)}\n"
      if logic.player_won?(player.player_number)
        puts "Player #{player.name} wins!\n\n"
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
    puts "Player 2: 'O'"
    puts "\n\n"
  end

  def player_turn(player)
    print "Player #{player.name} turn, please enter a number: "
    gets.chomp
  end

  def assign_names(times_call)
    puts "What is your name player #{times_call ? 1 : 2}?"
    name = gets.chomp
    until logic.valid_name(name, times_call ? '' : @player1.name)
      print "#{logic.error_message} Write it again: "
      name = gets.chomp
    end
    puts "\n"
    mark = times_call ? 'X' : 'O'
    @player1 = Player.new(name, mark, 1) if times_call
    @player2 = Player.new(name, mark, 2) unless times_call
    nil
  end
end

Main.new
