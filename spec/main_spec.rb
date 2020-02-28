require_relative '../bin/main.rb'
require_relative '../lib/board.rb'
require_relative '../lib/logic.rb'
require_relative '../lib/player.rb'
require 'stringio'

RSpec.describe Main do
  let(:instructions) { "Welcome to Tic-tac-toe\nSelect a number to replace with the given mark:\nPlayer 1: 'X'\nPlayer 2: 'O'\n\n\n" }
  let(:player_prompt) { "Player asd turn, please enter a number: " }
  let(:player1_name) { 'Mark' }
  let(:player2_name) { 'Eve' }

  describe '#initialize_variables' do
    it 'creates an instance of the class board' do
      main = Main.new
      main.initialize_variables
      expect(main.board).to be_an_instance_of(Board)
    end

    it 'creates an instance of the class logic' do
      main = Main.new
      main.initialize_variables
      expect(main.logic).to be_an_instance_of(Logic)
    end
  end

  describe '#instructions' do
    it 'prints the instructions for the game' do
      main = Main.new
      expect do
        main.instructions
      end.to output(instructions).to_stdout
    end
  end

  describe '#player_turn' do
    it 'prompts the player to make a move' do
      main = Main.new
      player = Player.new("asd", 'X', 1)
      expect do
        main.player_turn(player)
      end.to output(player_prompt).to_stdout
    end
  end

  describe '#assign_names' do
    main = Main.new

    it 'create an instance of a player and if the parameter given is true assign a name to player 1' do
      allow($stdin).to receive(:gets).and_return player1_name
      main.assign_names(true)
      expect(main.player1.name).to eql(player1_name)
    end

    it 'create an instance of a player and if the parameter given is false assign a name to player 2' do
      allow($stdin).to receive(:gets).and_return player2_name
      main.assign_names(false)
      expect(main.player2.name).to eql(player2_name)
    end
  end

  describe '#game_start' do
    it 'outputs the player that won and a game over message' do
      main = Main.new
      allow($stdin).to receive(:gets).and_return("asdasd", "asdw", "1", "2", "3", "4", "5", "6", "7")
      main.game_start
    end
  end
end