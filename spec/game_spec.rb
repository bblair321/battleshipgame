require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
    @player_board = Board.new
    @computer_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do
    it 'game to be instance of game' do

      expect(@game).to be_a(Game)
      expect(@player_board).to be_a(Board)
      expect(@computer_board).to be_a(Board)
    end
  end

  describe "#place_computer_ships" do
    it "places ships randomly on the computer board" do
     @game.place_computer_ships
     ship_cells = @game.computer_board.cells.values.select { |cell| cell.ship }
    
     expect(ship_cells.count).to eq(5)  
     end
  end
end  