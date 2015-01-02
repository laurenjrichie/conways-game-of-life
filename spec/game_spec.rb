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
      #   ["O", "O", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["O", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "0", "0",],
      #   ["-", "-", "-", "-", "_", "_", "_", "-", "-", "X",],
      #   ["-", "-", "-", "-", "-", "_", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      #   ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-",],
      # ]
  end

  it 'finding neighbors deals with edge cases' do
    @game.custom_seed(0,1)
    @game.custom_seed(1,0)
    @game.custom_seed(3,9)
    @game.custom_seed(3,10)

    expect(@game.neighbors(0,0).count("O")).to eq(2)
    expect(@game.neighbors(4,10).count("O")).to eq(2)
  end


  it 'any live cell with fewer than two live neighbors dies' do
    @game.custom_seed(4,4)
    @game.custom_seed(4,5)

    expect(@game.live_or_die?(4, 5)).to eq("die")
  end

  it 'any live cell with more than three live neighbors dies' do
    @game.custom_seed(4,4)
    @game.custom_seed(4,5)
    @game.custom_seed(5,4)
    @game.custom_seed(5,5)
    @game.custom_seed(6,5)

    expect(@game.live_or_die?(5, 4)).to eq("die")
  end

  it 'any live cell with two or three live neighbors lives' do
    @game.custom_seed(3,4)
    @game.custom_seed(4,4)
    @game.custom_seed(4,5)
    @game.custom_seed(4,6)
    @game.custom_seed(5,5)

    expect(@game.live_or_die?(5, 5)).to eq("live")
    expect(@game.live_or_die?(3, 4)).to eq("live")
  end

  it 'any dead cell with exactly three live neighbors comes to life' do
    @game.custom_seed(4,4)
    @game.custom_seed(4,5)
    @game.custom_seed(5,5)

    expect(@game.live_or_die?(5, 4)).to eq("live")
  end

  it 'moves to the next generation and applies the live or die method to each cell'


end
