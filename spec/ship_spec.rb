require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end
  describe 'initialize' do
    it 'can initialize' do
      
    expect(@cruiser).to be_an_instance_of(Ship)
    end
  end  
  describe 'has attibutes' do
    it 'it has name' do
      
    expect(@cruiser.name).to eq("Cruiser")
    end
    it 'it has length' do
      
    expect(@cruiser.length).to eq(3)
    end

    it 'it has health' do
      
    expect(@cruiser.health).to eq(3)
    end

  end
end