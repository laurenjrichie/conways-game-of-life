require_relative 'cell'

class Grid
  attr_reader :grid

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @grid = []
    rows.times do
      row = []
      columns.times do
        row << Cell.new
      end
      @grid << row
    end
  end

  def number_alive
    status_array = []
    @grid.flatten.each {|cell| status_array << cell.status }
    status_array.count("alive")
  end

  def fill_in_dead
    @grid.each do |row|
      row.each do |cell|
        cell.dead if cell.status != "alive"
      end
    end
  end

  def random_seed(live_cells)
    while number_alive < live_cells
      row = rand(0..(@rows-1))
      @grid[row][0].alive
      @grid[row] = @grid[row].sort_by {rand}
    end

    fill_in_dead
    @grid
  end

  def custom_seed(row, column)
    @grid[row][column].alive
    fill_in_dead
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
    right = @grid[row][column+1] unless column == (@columns-1)
    if row != (@rows-1)
      bottom_left = @grid[row+1][column-1]
      bottom = @grid[row+1][column]
      bottom_right = @grid[row+1][column+1]
    end

    neighbors.push(top_left, top, top_right, left, right, bottom_left, bottom, bottom_right)
    neighbors.compact
  end

  def count_live_neighbors(row, column)
    cell = @grid[row][column]
    live_neighbors = 0
    neighbors(row, column).each do |cell|
      live_neighbors += 1 if cell.status == "alive"
    end
    live_neighbors
  end

  def live_or_die?(row, column)
    live_neighbors = count_live_neighbors(row, column)
    cell = @grid[row][column]
    if cell.status == "alive"
      if live_neighbors < 2 || live_neighbors > 3
        fate = "die"
      elsif live_neighbors == 2 || live_neighbors == 3
        fate = "live"
      end
    elsif cell.status == "dead"
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
          new_row << Cell.new.alive
        elsif fate == "die"
          new_row << Cell.new.dead
        end
      end
      next_gen << new_row
    end
    @grid = next_gen
  end

  def print_grid(array)
    array.each do |row|
      row.each do |cell|
        print "O" if cell.status == "alive"
        print " " if cell.status == "dead"
      end
      puts ''
    end
    puts ''
  end

end

game = Grid.new(50, 50)
seed_gen = game.random_seed(250)
first_gen = game.next_gen
second_gen = game.next_gen

game.print_grid(seed_gen)
p "****************************"
game.print_grid(first_gen)
p "****************************"
game.print_grid(second_gen)
