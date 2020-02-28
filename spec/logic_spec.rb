require './lib/logic.rb'
require './lib/player.rb'
require './lib/error.rb'

RSpec.describe Logic do
  let(:mock_logic) { Logic.new }
  let(:error_message) { Error.new }
  let(:player1) { 1 }
  let(:player2) { 2 }
  let(:win_cases) { [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]] }
  let(:win_case_one) { [1, 2, 3] }
  let(:win_case_two) { [4, 5, 6] }
  let(:win_case_three) { [7, 8, 9] }
  let(:win_case_four) { [1, 4, 7] }
  let(:win_case_five) { [2, 5, 8] }
  let(:win_case_six) { [3, 6, 9] }
  let(:win_case_seven) { [1, 5, 9] }
  let(:win_case_eigth) { [3, 5, 7] }

  describe '#valid_name' do
    it 'returns true if the name entered is whithin the acceptable lenght' do
      expect(mock_logic.valid_name('new', '')).to be true
    end

    it 'returns false if the name entered is too long' do
      expect(mock_logic.valid_name('thisisalongname', '')).to be false
    end

    it 'returns true if the name entered is different than the previous name' do
      expect(mock_logic.valid_name('new', 'old')).to be true
    end

    it 'returns false if the name entered is the same as the previous name' do
      expect(mock_logic.valid_name('old', 'old')).to be false
    end

    it 'returns false if the name entered is empty' do
      expect(mock_logic.valid_name(' ', 'old')).to be false
    end
  end

  describe '#check_move' do
    it "returns true if the space selected hasn't been ocupied yet" do
      expect(mock_logic.check_move(1, player1)).to be true
    end

    it "returns false if the space selected has been ocupied" do
      mock_logic.check_move(1, player1)
      expect(mock_logic.check_move(1, player2)).to be false
    end

    it "increases the moves count if it's a valid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(2, player2)
      expect(mock_logic.moves).to eql(2)
    end

    it "doesn't increase the moves count if it's an invalid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(1, player2)
      expect(mock_logic.moves).to eql(1)
    end

    it "pushes the number to the board_choices array if it's a valid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(2, player2)
      board_choices = [1, 2]
      expect(mock_logic.board_choices).to eql(board_choices)
    end

    it "doesn't push the number to the board_choices array if it's an invalid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(1, player2)
      board_choices = [1]
      expect(mock_logic.board_choices).to eql(board_choices)
    end

    it "pushes the number to the player_choices array if it's a valid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(2, player1)
      player1_choices = [1, 2]
      expect(mock_logic.player1_choices).to eql(player1_choices)
    end

    it "doesn't push the number to the player_choices array if it's an invalid move" do
      mock_logic.check_move(1, player1)
      mock_logic.check_move(1, player1)
      player1_choices = [1]
      expect(mock_logic.player1_choices).to eql(player1_choices)
    end
  end

  describe '#check_input' do
    it 'returns true if the input passed is a number between 1 to 9' do
      expect(mock_logic.check_input("1", player1)).to be true
    end

    it "returns false if the input passed isn't a number between 1 to 9" do
      expect(mock_logic.check_input("a", player1)).to be false
    end

    it 'changes the error message if the input entered is empty or a space' do
      mock_logic.check_input(' ', player1)
      expect(mock_logic.error_message).to eql(Error::INVALID_NUMBERS_EMPTY)
    end

    it 'changes the error message if the input entered is a float' do
      mock_logic.check_input('1.5', player1)
      expect(mock_logic.error_message).to eql(Error::INVALID_NUMBERS_FLOATS)
    end

    it "changes the error message if the input entered isn't a number between 1 and 9" do
      mock_logic.check_input('-96', player1)
      expect(mock_logic.error_message).to eql(Error::INVALID_NUMBERS_RANGE)
    end

    it 'changes the error message if the input entered is a letter or a word' do
      mock_logic.check_input('asdas', player1)
      expect(mock_logic.error_message).to eql(Error::INVALID_NUMBERS_LETTER)
    end

    it "changes the error message if the input entered isn't a number, a letter or a word" do
      mock_logic.check_input('+,{', player1)
      expect(mock_logic.error_message).to eql(Error::INVALID_NUMBERS_SYMBOL)
    end
  end

  describe '#tie?' do
    it 'return true if the moves_count is equal to 9.' do
     [1, 2, 1, 2, 2, 1, 1, 1, 2].each_with_index do |player, index|
        mock_logic.check_move(index + 1, player)
     end
     expect(mock_logic.tie?).to be true
    end

    it 'return nil if the moves_count is less than 9.' do
     [1, 2, 1, 2, 1, 2, 1].each_with_index do |player, index|
        mock_logic.check_move(index + 1, player)
     end
     expect(mock_logic.tie?).to eql(nil)
    end
  end

  describe '#player_won?' do
    it 'return false if the player has not won yet.' do
      expect(mock_logic.player_won?(player1)).to be false
    end

    it 'return true if the player one match win case one.' do
      win_case_one. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case one.' do
      win_case_one. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end

    it 'return true if the player one match win case two.' do
      win_case_two. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case two.' do
      win_case_two. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end


    it 'return true if the player one match win case three.' do
      win_case_three. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case three.' do
      win_case_three. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end

    it 'return true if the player one match win case four.' do
      win_case_four. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case four.' do
      win_case_four. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end


    it 'return true if the player one match win case five.' do
      win_case_five. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case five.' do
      win_case_five. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end

    it 'return true if the player one match win case six.' do
      win_case_six. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case six.' do
      win_case_six. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end


    it 'return true if the player one match win case seven.' do
      win_case_seven. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case seven.' do
      win_case_seven. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end


    it 'return true if the player one match win case eigth.' do
      win_case_eigth. each do |move|
        mock_logic.check_move(move, player1)
      end
      expect(mock_logic.player_won?(player1)).to be true
    end

    it 'return true if the player two match win case eigth.' do
      win_case_eigth. each do |move|
        mock_logic.check_move(move, player2)
      end
      expect(mock_logic.player_won?(player2)).to be true
    end
  end
end