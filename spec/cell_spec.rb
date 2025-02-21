require './lib/ship'
require './lib/cell'
RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end
  describe "@initialize"do
    it "exists" do
      expect(@cell).to be_a(Cell)
    end
    it "has a coordinate" do
      expect(@cell.coordinate).to eq("B4")
    end
    it "has a ship" do
      expect(@cell.ship).to eq(nil)
    end
  end

  describe "#place_ship" do
    it "adds ship" do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe "@empty?" do
    it "changes the value of empty" do
      @cell.place_ship(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe "#fire_upon is false" do
    it "is false" do
      expect(@cell.fired_upon?).to eq(false)
    end
  end
  describe "#fire_upon" do
   it "checks if ship was fired upon" do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end
   
  
end