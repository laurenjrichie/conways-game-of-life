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

    expect(@game.seed(live_cells).flatten.count("O")).to eq(live_cells)
    expect(@game.seed(live_cells).flatten.count("-")).to eq(dead_cells)
  end

end
