require 'game'
require 'spec_helper'

describe GameOfLife do
  before do
    @game = GameOfLife.new
  end

  it 'has a two-dimensional grid' do
    expect(@game.grid).to eq(
      [
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
    )
  end

  it 'seeds the grid with an initial random pattern of live cells' do
    live_cells = 40
    dead_cells = (10*10) - live_cells

    expect(@game.random_seed(live_cells).flatten.count("O")).to eq(live_cells)
    expect(@game.random_seed(live_cells).flatten.count("-")).to eq(dead_cells)
  end

  it 'has a custom seed method' do
    row = 4
    column = 5

    expect(@game.custom_seed(row, column)).to eq(
      [
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "O", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
        ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      ]
    )
  end

  it 'has a method to find all 8 neighbors of a given cell' do
    @game.custom_seed(4,4)
    @game.custom_seed(4,5)
    @game.custom_seed(4,6)
    @game.custom_seed(3,5)
    @game.custom_seed(5,5)
    row = 4
    column = 5

    expect(@game.neighbors(row, column)).to eq(["-", "O", "-", "O", "O", "-", "O", "-"])
      # [
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "O", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "O", "O", "O", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "O", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      # ]
  end

  it 'has a method to find vertical neighbors'

  it 'has a method to find diagonal neighbors'

  it 'has a method to find all neighbors'

end
