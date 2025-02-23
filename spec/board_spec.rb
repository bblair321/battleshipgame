require './lib/board'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end
  describe "#initialize" do
    it 'exists and starts with an empty hash' do
      expect(@board).to be_a(Board)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.empty?).to eq(true)  # it`s empty at first
    end
  end

  describe "#generate_cells" do
    it 'can generate cells when requested' do
      @board.generate_cells

      expect(@board.cells.length).to eq(16)  #Now it``s filled
      expect(@board.cells.keys).to include("A1", "D4")
      expect(@board.cells["A1"]).to be_a(Cell)
      expect(@board.cells["D4"]).to be_a(Cell)
    end
  end
end