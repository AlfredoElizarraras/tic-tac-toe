class Player
  attr_reader :name, :mark, :player_number

  def initialize(name,mark,player_number)
    @name = name
    @mark = mark
    @player_number = player_number
  end
end