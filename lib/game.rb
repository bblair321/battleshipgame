class Game
  attr_reader :menu,:player_board, :computer_board
  def initialize
  end

  def menu
      puts "Welcome to Battleship!"
      loop do
      puts "Enter p to play. Enter q to quit."
      input = gets.chomp.downcase

      case input
      when "p"
        puts "Let's play!"
        break
      when "q"
          puts "Thanks, Goodbye!"
          exit
      else
            puts "Invalid input. Please enter p to play or q to quit."
      end      
    end
  end
end