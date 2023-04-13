class Prototype
  attr_accessor :cards, :balance, :sum

  def initialize
    @cards = []
    @balance = 100
    @sum = 0
  end

  def add_card(card)
    cards << card
    if card['card'].chars.first == 'A'
      if sum > 10
        @sum += 1
      else
        @sum += 11
      end
    else
      @sum += card['equivalent']
    end
  end
end