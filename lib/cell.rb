class Cell
  attr_accessor :status

  def initialize
    @status
  end

  def dead
    @status = "dead"
    self
  end

  def alive
    @status = "alive"
    self
  end
end
