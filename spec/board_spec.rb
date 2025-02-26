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
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
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

    it 'returns false for overlapping' do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expect(@board.valid_placement?(@submarine, ["A1", "A3"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3"])).to be false
      expect(@board.valid_placement?(@submarine, ["B1", "B2"])).to be true
    end
  end
  describe "#place" do
    it 'places the ship' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
      expect(@board.cells["A1"].ship).to eq(@board.cells["A2"].ship)
      expect(@board.cells["A2"].ship).to eq(@board.cells["A3"].ship)

    end
  end
  describe "#render" do
    it 'renders an empty board' do
      expected_output = "--1 2 3 4 \n" +
                      "A . . . . \n" +
                      "B . . . . \n" +
                      "C . . . . \n" +
                      "D . . . ."
                    
      expect(@board.render).to eq(expected_output)
    end
    it 'renders a board with ships hidden' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
  
      expected_output =   "--1 2 3 4 \n" +
                        "A . . . . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . ."
  
      expect(@board.render).to eq(expected_output)
    end
  
    it 'renders a board with ships revealed' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
  
      expected_output =   "--1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . ."
  
      expect(@board.render(true)).to eq(expected_output)
    end
  

   it 'renders a board with hits and misses' do
     @board.place(@cruiser, ["A1", "A2", "A3"])
     @board.cells["A1"].fire_upon  
     @board.cells["B3"].fire_upon  

     expected_output =  "--1 2 3 4 \n" +
                      "A H . . . \n" +
                      "B . . M . \n" +
                      "C . . . . \n" +
                      "D . . . ."

     expect(@board.render).to eq(expected_output)
   end

   it 'renders a board with a sunk ship' do
     @board.place(@cruiser, ["A1", "A2", "A3"])
     @board.cells["A1"].fire_upon
     @board.cells["A2"].fire_upon
     @board.cells["A3"].fire_upon  

    expected_output =   "--1 2 3 4 \n" +
                      "A X X X . \n" +
                      "B . . . . \n" +
                      "C . . . . \n" +
                      "D . . . ."

     expect(@board.render).to eq(expected_output)
    end
  end
end  