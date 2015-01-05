require 'cell'
require 'spec_helper'

describe Cell do

  it 'can make a cell live or die and check the status' do
    cell_1 = Cell.new.dead
    cell_2 = Cell.new.alive

    expect(cell_1.status).to eq("dead")
    expect(cell_2.status).to eq("alive")
  end

end
