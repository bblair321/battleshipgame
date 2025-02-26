require './lib/cell'
class Board
  attr_reader :cells

  def initialize
    @cells = {}

    generate_cells
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

    return false unless coordinates.all? { |coord| valid_coordinate?(coord) }
    return false if coordinates.any? { |coord| @cells[coord].ship }
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

  end 

  def place(ship, coordinates)
    generate_cells
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
    end
  end
 
  def render(reveal_ships = false)
    board_display = "--1 2 3 4\n"
    rows = ["A", "B", "C", "D"]
    rows.each do |row|
      row_display = "#{row} "
      (1..4).each do |col|
        cell_key = "#{row}#{col}"
        row_display += "#{@cells[cell_key].render(reveal_ships)} "
      end
      board_display += row_display + "\n"
    end
    board_display.strip
  end 
end