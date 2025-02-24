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
    return false unless consecutive_coordinates?(coordinates)
    true  
  end

  def consecutive_coordinates?(coordinates)
    rows = []
    columns = []
    coordinates.each do |coord|
      rows << coord[0]
      columns << coord[1..-1].to_i
    end
    if rows.uniq.length == 1
      columns.sort!
      columns.each_cons(2).all? do |first, second|
       second == first + 1
      end
    elsif columns.uniq.length == 1
      rows.sort!
      rows.each_cons(2).all? do |first, second|
        second == first.next
      end
    else
       false
    end
     #def 
  end 
end 

######