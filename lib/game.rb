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

  def neighbors(row, column)
    neighbors = []
    if row != 0
      top_left = @grid[row-1][column-1]
      top = @grid[row-1][column]
      top_right = @grid[row-1][column+1]
    end
    left = @grid[row][column-1] unless column == 0
    right = @grid[row][column+1] unless column == 9
    if row != 9
      bottom_left = @grid[row+1][column-1]
      bottom = @grid[row+1][column]
      bottom_right = @grid[row+1][column+1]
    end

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

  def next_gen
    next_gen = []
    @grid.each_with_index do |row, index|
      row_number = index
      new_row = []
      row.each_with_index do |cell, index|
        column_number = index
        fate = live_or_die?(row_number, column_number)
        if fate == "live"
          new_row << "O"
        elsif fate == "die"
          new_row << "-"
        end
      end
      next_gen << new_row
    end
    @grid = next_gen
  end

  def print_grid(array)
    array.each do |row|
      p row
    end
    puts ''
  end

end

game = GameOfLife.new
seed_gen = game.random_seed(50)
first_gen = game.next_gen
second_gen = game.next_gen

game.print_grid(seed_gen)
game.print_grid(first_gen)
game.print_grid(second_gen)
