class GameOfLife
  attr_reader :grid

  def initialize
    @grid = [
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
    ]
  end

  def random_seed(live_cells)
    while @grid.flatten.count("O") < live_cells
      row = rand(0..9)
      @grid[row][0] = "O"
      @grid[row] = @grid[row].sort_by {rand}
    end
    @grid
  end

  def custom_seed(row, column)
    @grid[row][column] = "O"
    @grid
  end

  def neighbors(row, column)   # deal with edge cases!!!
    neighbors = []
    top_left = @grid[row-1][column-1]
    top = @grid[row-1][column]
    top_right = @grid[row-1][column+1]
    left = @grid[row][column-1]
    right = @grid[row][column+1]
    bottom_left = @grid[row+1][column-1]
    bottom = @grid[row+1][column]
    bottom_right = @grid[row+1][column+1]

    neighbors.push(top_left, top, top_right, left, right, bottom_left, bottom, bottom_right)
  end

  def live_or_die?(row, column)
    cell = @grid[row][column]
    live_neighbors = neighbors(row, column).count("O")
    if cell == "O"
      if live_neighbors < 2 || live_neighbors > 3
        fate = "die"
      elsif live_neighbors == 2 || live_neighbors == 3
        fate = "live"
      end
    elsif cell == "-"
      if live_neighbors == 3
        fate = "live"
      else
        fate = "die"
      end
    end
    fate
  end

end
