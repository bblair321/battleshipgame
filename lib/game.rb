require './lib/board'
require './lib/ship'
class Game
  attr_reader :player_board, :computer_board
  def initialize
     @player_board = Board.new
     @computer_board = Board.new
  end

  def menu
      puts "Welcome to Battleship!"
      loop do
      puts "Enter p to play. Enter q to quit."
      input = gets.chomp.downcase

      case input
      when "p"
        puts "Let's play!"
        start_game
        break
      when "q"
          puts "Thanks, Goodbye!"
          exit
      else
            puts "Invalid input. Please enter p to play or q to quit."
      end      
    end
  end
  def start_game
    puts "Generating game for you"
  
    place_computer_ships
    place_player_ships

    puts "Game setup complete. Let's start!"
  end

  def place_computer_ships
     puts "Computer is placing its ships"

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

     place_random_ship(@computer_board, cruiser)
     place_random_ship(@computer_board, submarine)

     puts "Computer has placed its ships."
  end

  def place_random_ship(board, ship)
    loop do
      start_cell = board.cells.keys.sample 
      orientation = ["horizontal", "vertical"].sample
      coordinates = generate_coordinates(board, start_cell, ship.length, orientation)
      if coordinates && board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        break
      end
    end
  end

  def generate_coordinates(board, start_cell, ship_size, orientation)
    row, col = start_cell.chars
    col = col.to_i

    if orientation == "horizontal"
      end_col = col + ship_size - 1
      return nil if end_col > 4  

      coordinates = (col..end_col).map { |c| "#{row}#{c}" }
    else
      end_row = (row.ord + ship_size - 1).chr
      return nil if end_row > "D"  

      coordinates = (row.ord..end_row.ord).map { |r| "#{r.chr}#{col}" }
    end

    coordinates if coordinates.all? { |coord| board.valid_coordinate?(coord) }
  end
  def place_player_ships
    puts "You need to place your ships."
    
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    
    place_player_ship(@player_board, cruiser)
    
    place_player_ship(@player_board, submarine)
    
    puts "Your ships are placed! Game is ready to begin."
  end
    
  def place_player_ship(board, ship)
      loop do
      puts board.render(true)
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces), separated by spaces:"
      
      coordinates = gets.chomp.upcase.split(" ")
      
      
      if board.valid_placement?(ship, coordinates)
        board.place(ship, coordinates)
        break
      else
        puts "Those are invalid coordinates. Please try again."
      end
    end
  end
end