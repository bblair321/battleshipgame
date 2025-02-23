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

  describe "#valid_coordinate?" do
    it 'can generate cells when requested' do
      @board.generate_cells
      @board.valid_coordinate?("A1")
      @board.valid_coordinate?("D4")
      @board.valid_coordinate?("A5")
      @board.valid_coordinate?("E1")
      @board.valid_coordinate?("A22")
     
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
    end
  end


  describe "#valid_placement" do
    it 'returns false if the number of coordinates does not match ship length' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["B1", "B2", "B3"])).to eq(false)
    end
    
    it 'returns true for the right placement' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end

    it 'returns true for consecutive placement' do 
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "B2", "B3"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end

    it 'returns false for non-consecutive row placement' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A3", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A3", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "A4"])).to eq(false)
    end
    
    it 'returns false for diagonal placement' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
    end
  end


end