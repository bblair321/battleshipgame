require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
    @player_board = Board.new
    @computer_board = Board.new
  end

  describe "#initialize" do
    it 'game to be instance of game' do

      expect(@game).to be_a(Game)
      expect(@player_board).to be_a(Board)
      expect(@computer_board).to be_a(Board)
    end
  end
end  