class Dealer

  attr_accessor :cards, :bank

  def initialize
    @cards = []
    @bank = 100
    @sum = 0
  end
end