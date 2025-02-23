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
end