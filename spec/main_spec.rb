require_relative '../bin/main.rb'
require_relative '../lib/board.rb'
require_relative '../lib/logic.rb'
require_relative '../lib/player.rb'
require 'stringio'

RSpec.describe Main do
  #let(:main) { Main.new }
  let(:instructions) { "Welcome to Tic-tac-toe\nSelect a number to replace with the given mark:\nPlayer 1: 'X'\nPlayer 2: 'O'\n\n\n" }
  let(:player_prompt) { "Player asd turn, please enter a number: " }

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

    before do
      $stdin = StringIO.new("asd\n")
    end

    after do
      $stdin = STDIN
    end

    it 'asdasd' do
      expect(main.assign_names(true)).to eql("asd")
    end
  end
end