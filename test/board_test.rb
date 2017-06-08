require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

	def test_create
		board = Board.new
		refute_nil board
    refute_nil board.coordinates
    assert_equal " ", board.coordinates["A"][0]
    refute_equal "S", board.coordinates["A"][0]
	end

  def test_place_ship
    board = Board.new

    board.place_ship(1, "A1 A2")

    assert_equal " ", board.coordinates["A"][3]
    assert_equal 1, board.coordinates["A"][0]
    assert_equal 1, board.coordinates["A"][1]

  end

  def test_place_ship_out_of_bounds
    # must write this test and code
  end

  def test_receive_shot
    board = Board.new
    board.place_ship(1, "A1 A2")

    assert_equal "hit", board.receive_shot("A", 1)
    assert_equal "hit", board.receive_shot("A", 2)
    assert_equal "miss", board.receive_shot("A", 3)
  end

  def test_ship_sunk?
    board = Board.new
    board.place_ship(1, "A1 A2")

    refute board.ship_sunk?(1)
    assert board.ship_sunk?(2)
  end

  def test_receive_shot_out_of_bounds
    board = Board.new
    refute board.receive_shot("A", 6)
  end

  def test_valid_coordinate?
    board = Board.new

    refute board.valid_coordinate?("A", 6)
    refute board.valid_coordinate?("G", 3)
    assert board.valid_coordinate?("A", 5)
    assert board.valid_coordinate?("D", 1)
  end
end
