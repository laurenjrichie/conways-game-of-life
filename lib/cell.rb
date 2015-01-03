require_relative 'grid'

module GameOfLife
class Cell
  attr_accessor :status

  def initialize
    @status
  end

  def dead
    @status = "-"
    self
  end

  def alive
    @status = "O"
    self
  end

end
end
