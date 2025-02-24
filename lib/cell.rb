class Cell
  attr_reader :coordinate, :ship
  
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end
  
  def fired_upon?
    @fired_upon
  end
  
  def fire_upon
    @fired_upon = true
    @ship.hit if @ship 
  end

  def render(reveal = false)
    return "X" if @ship && @ship.sunk?
    return "H" if @ship && @fired_upon
    return "M" if @fired_upon
    return "S" if @ship && reveal
    "."
  end
  
end