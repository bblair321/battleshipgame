require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end
  describe "#initialize" do
    it 'exists and starts with an empty hash' do
      expect(@board).to be_a(Board)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.empty?).to eq(true)  
    end
  end

  describe "#generate_cells" do
    it 'can generate cells when requested' do
      @board.generate_cells

      expect(@board.cells.length).to eq(16)  
      expect(@board.cells.keys).to include("A1", "D4")
      expect(@board.cells["A1"]).to be_a(Cell)
      expect(@board.cells["D4"]).to be_a(Cell)
    end
  end
end