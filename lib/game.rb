require './lib/board'

class Game
  attr_accessor :players_grid
				  :computers_grid
          :players_view_of_computers_grid

  def initialize
    @players_grid = Board.new
    @computers_grid = Board.new
    @players_view_of_computers_grid = Board.new
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
		puts "I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.
Enter the squares for the two-unit ship, like this Z1 Z2:"

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
    #
    @players_grid.print_self
    # ask the user where they would like to Shoot
    # @computers_grid.receive_shot(users_input)
    # If the response is hit, then mark @players_view_of_computers_grid as a hit
    # if the response is miss, then mark @players_view_of_computers_grid as a miss
    # if the response is sunk, then check if the computer has any ships left
    system "clear"
    p "Attack your opponent! Choose a square coordinate where to shoot, like this W1:"
    users_input = gets.chomp.split('')
    @computers_grid.receive_shot(users_input[0], users_input[1].to_i)
    @computers_grid = Board.new


    @computers_grid.print_self
    gets.chomp
    @players_grid = Board.new

  end

  # puts "Enter your chosen ship coordinates like this: E1 E2"
  # puts "Take a shot!"
  # @shot_coordinate = gets.chomp.upcase.split('')

end

game = Game.new
system "clear"
puts "Welcome to BATTLESHIP"
puts
game.play_game
