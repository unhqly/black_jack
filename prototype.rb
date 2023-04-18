# frozen_string_literal: true

class Prototype
  attr_accessor :cards, :balance, :sum

  def initialize
    @cards = []
    @balance = 100
    @sum = 0
  end

  def add_card(card)
    cards << card
    @sum += card['equivalent']
  end
end
