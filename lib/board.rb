class Board
  attr_reader :cells

  def initialize
    @cells = {}  
  end

  def generate_cells
    rows = ["A", "B", "C", "D"]
    cols = ["1", "2", "3", "4"]

    rows.each do |row|
      cols.each do |col|
        coordinate = row + col
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.length != ship.length

  
  end
end
