class Player

  attr_accessor :cards, :bank, :sum

  def initialize(name)
    @name = name
    @cards = []
    @bank = 100
    @sum = 0
  end
end