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

      expect(@cruiser.hit).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  end
  
  describe "#render" do
    it "checks how a cell can be rednered" do
      @cell.render

      expect(@cell.render).to eq(".")
    end
  end 
  describe "#render" do
    it "checks how a cell can be rendered M" do
      @cell.fire_upon

      expect(@cell.render).to eq("M")
    end
  end 
  describe "#render" do
    it "checks how a cell can be rendered H" do
      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.render).to eq("H")
    end
  end 
  describe "#render" do
    it "renders 'X' when the ship is sunk" do
      @cell.place_ship(@cruiser)
      3.times { @cruiser.hit } # Reduce ship health to 0
      expect(@cell.render).to eq("X")
    end
  end 

  describe "#render" do
    it "renders 'S' when the ship is sunk" do
      @cell = Cell.new("C3")
      @cell.place_ship(@cruiser)
    
      expect(@cell.render(true)).to eq("S")
    end
  end 
end