class Board
  attr_accessor :coordinates

	def initialize
    @coordinates = {
                  "A" => coordinate_row.dup,
                  "B" => coordinate_row.dup,
                  "C" => coordinate_row.dup,
                  "D" => coordinate_row.dup,
                  "E" => coordinate_row.dup
  	              }
  end

  def coordinate_row
    [" ", " ", " ", " ", " "]
  end

  def print_board
    system "clear"
    puts "======================"
    puts "   1   2   3   4   5  "
    @coordinates.each do |key, coordinate_row|
      print key + " "
      puts coordinate_row.join(" ")
    end
    puts "====================="
  end

  def input_range(input)
  end

  def place_ship(ship_number, coordinates)
    list_of_coordinates = coordinates.upcase.split(' ')
    list_of_coordinates.each do |coordinate|
      @coordinates[coordinate[0]][coordinate[1].to_i - 1] = ship_number
    end
    "success"
  end

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

  def set_a_miss(letter_coordinate, number_coordinate)
    @coordinates[letter_coordinate][number_coordinate - 1] = "M"
  end

  def set_a_hit(letter_coordinate, number_coordinate)
    @coordinates[letter_coordinate][number_coordinate - 1] = "H"
  end
end

board = Board.new
board.place_ship(1, "A1 A2 A3")
board.place_ship(2, "C5 D5 E5")
board.print_board
