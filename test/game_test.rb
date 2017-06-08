require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require './lib/grid'
require 'pry'

class GameTest < Minitest::Test

  def test_board_class_initializes_with_game
    game = Game.new

    assert_instance_of Board, game.player_grid
  end

  def test_layout_phase_has_message

  end

end
