class Prototype
  attr_accessor :cards, :bank, :sum

  def initialize
    @cards = []
    @bank = 100
    @sum = 0
  end

  def add_card(deck)
    number = rand(deck.available_cards.size)
    @cards << deck.available_cards[number]
    deck.available_cards.delete_at(number)
  end
end