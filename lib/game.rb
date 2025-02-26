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

    turn_loop
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

  def turn_loop
    loop do
      player_turn
      break if game_over?

      computer_turn
      break if game_over?
    end
  end

  def player_turn
    puts "Your turn!"
    puts "Here is your opponent’s board:"
    puts @computer_board.render

    loop do
      puts "Enter a coordinate to fire at:"
      coordinate = gets.chomp.upcase

      if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        @computer_board.cells[coordinate].fire_upon
        puts "You fired at #{coordinate}!"
        puts @computer_board.render
        break
      else
        puts "Invalid coordinate or already fired upon. Try again."
      end
    end
  end

  def computer_turn
    puts "Computer's turn..."
    loop do
      coordinate = @player_board.cells.keys.sample
      unless @player_board.cells[coordinate].fired_upon?
        @player_board.cells[coordinate].fire_upon
        puts "Computer fired at #{coordinate}!"
        puts @player_board.render(true)
        break
      end
    end
  end

  def game_over?
    if all_ships_sunk?(@computer_board)
      puts "You win! All enemy ships have been sunk!"
      return true
    elsif all_ships_sunk?(@player_board)
      puts "Computer wins! All your ships have been sunk."
      return true
    end
    false
  end

  def all_ships_sunk?(board)
    # Gets a list of all unique ships currently on the board
    ships = board.cells.values.map(&:ship).compact.uniq

    puts "Checking if all ships are sunk..."
    ships.each { |ship| puts "#{ship.name}: #{ship.sunk? ? 'SUNK' : 'ALIVE'} (Health: #{ship.health})" }

    return false if ships.empty?

    ships.all?(&:sunk?)
  end
end