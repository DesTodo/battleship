require './lib/board'
require './lib/message'

class Game
  attr_accessor :player_grid, :computer_grid, :player_view_of_computer_grid,
                :message

  def initialize
    @player_grid                   = Board.new
    @computer_grid                 = Board.new
    @player_view_of_computer_grid  = Board.new
    @message                       = Message.new
  end

  def play_game
    user_input = ""
    while user_input != "q"
      system "clear"
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      user_input = gets.chomp
        if user_input == "i"
          puts "These are the instructions for how to play battleship."
        elsif user_input == "p"
          ship_layout_phase
        elsif user_input == "q"
          puts "You have chosen to quit BATTLESHIP. Thank you for playing!"
        else
          puts "#{user_input} is an invalid command."
        end
    end
  end

  def ship_layout_phase
    system "clear"
    @message.ship_layout_phase_message
    first_ship = gets.chomp
    @players_grid.place_ship(1, first_ship)
    system "clear"
    p "Enter the squares for your three-unit ship, like this Y1 Y2 Y3:"
    second_ship = gets.chomp
    @players_grid.place_ship(2, second_ship)
    @computers_grid.place_ship(1, "A1 A2")
    @computers_grid.place_ship(2, "C5 D5 E5")
    battle_phase
  end

  def battle_phase
    @players_grid.print_board
    system "clear"
    p "Attack your opponent! Choose a square coordinate where to shoot, like this W1:"
    users_input = gets.chomp.split('')
    outcome = @computers_grid.receive_shot(users_input[0], users_input[1].to_i)
      if outcome.is_a? Numeric
        @players_view_of_computers_grid.set_a_hit(users_input[0], users_input[1].to_i)
      else
        @players_view_of_computers_grid.set_a_miss(users_input[0], users_input[1].to_i)
      end
    @computers_grid = Board.new
    @computers_grid.set_a_miss(users_input[0], users_input[1].to_i)
    @computers_grid.print_board
    gets.chomp
    @players_grid = Board.new
  end

end

game = Game.new
system "clear"
puts "Welcome to BATTLESHIP"
puts
game.play_game
