class Player
  attr_accessor :my_grid, :opponents_grid
  attr_reader   :name

	def initialize(name)
		@name = name
		@my_grid = Grid.new
		@opponents_grid = Grid.new
	end

  def shoot

  end

end
