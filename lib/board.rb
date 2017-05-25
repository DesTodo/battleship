require 'pry'

class Board
attr_accessor :coordinates

	def initialize
		coordinate_row = [" ", " ", " ", " ", " "]
    @coordinates = {
			"A" => coordinate_row.dup,
			"B" => coordinate_row.dup,
			"C" => coordinate_row.dup,
			"D" => coordinate_row.dup,
			"E" => coordinate_row.dup
		}
  end

  def print_self
    system "clear"
    puts "==========="
    puts ". 1 2 3 4 5"
    @coordinates.each do |key, coordinate_row|
      print key + " "
      puts coordinate_row.join(" ")
    end
    puts "==========="
  end


  # Call test_valid_coordinate
  # If Valid, change the values of these coordinates to the ship, then return a string that says, "Ship placed"
  # If they are Invalid, return a string that says "This is not valid"
  # ship_number == ship_value; first placed ship --> 1 per square; 2nd --> 2 per square
  def place_ship(ship_number, ship_coordinates)
    list_of_coordinates = ship_coordinates.upcase.split(' ')

    # Must add valudation for this ship

    list_of_coordinates.each do |coordinate|
      @coordinates[coordinate[0]][coordinate[1].to_i - 1] = ship_number
    end
    "success"
  end

  # Shoot at the board
  # Test if the coordinate has a ship on it
  # If it contains a ship, mark it struck, and return a string that says, "Ship Hit"
  # If it does not contain a ship, do not do anything, and return a string that says, "You missed"
  def receive_shot(letter_coordinate, number_coordinate)

    coordinate_value = @coordinates[letter_coordinate][number_coordinate.to_i - 1]

    if !valid_coordinate?(letter_coordinate, number_coordinate)
      false
      p "Invalid coordinate!! Make sure you choose a number 1-4 and letter A-D."
      gets.chomp
    elsif coordinate_value.is_a? Numeric
      coordinate_value = "H"
      if ship_sunk?(coordinate_value.to_i)
        "ship #{coordinate_value} is sunk!"
      else
        "hit"
      end
    else
      "miss"
    end
  end

  def ship_sunk?(ship_number)
    return_value = true
    @coordinates.each do |key, row|
      row.each do |coordinate_value|
        if coordinate_value.is_a?(Numeric) && coordinate_value.to_i == ship_number
          return_value = false
        end
      end
    end
    return_value
  end

  def valid_coordinate?(letter_coordinate, number_coordinate)
    if @coordinates[letter_coordinate].nil? || number_coordinate > 5 || number_coordinate < 1
      p "Invalid coordinate."
      false
    else
      true
    end
  end

  #  Methods to view the opponent's board
  def set_a_miss(letter_coordinate, number_coordinate)
    @coordinates[letter_coordinate][number_coordinate - 1] = "M"
  end

  def set_a_hit(letter_coordinate, number_coordinate)
    @coordinates[letter_coordinate][number_coordinate - 1] = "H"
  end
end

# board = Board.new
# board.place_ship(1, "A1 A2 A3")
# board.place_ship(2, "C5 D5 E5")
# board.print_self
