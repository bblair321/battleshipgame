require './lib/ship'
require './lib/cell'
RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
  end
  describe "@initialize"do
    it "exists" do
      expect(@cell).to be_a(Cell)
    end
    it "has a coordinate" do
      expect(@cell.coordinate).to eq("B4")
    end
  end
  
end