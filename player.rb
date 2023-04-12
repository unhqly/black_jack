require_relative 'prototype'

class Player < Prototype

  attr_accessor :name, :cards, :bank, :sum

  def initialize(name)
    @name = name
    @cards = []
    @bank = 100
    @sum = 0
  end

  def move(deck)
    puts "Choose next move"
    choice = gets.chomp
    
    case choice 
    when 'Pass'
      puts "Dealer's move"
    when 'Add'
      add_card(deck)
    when 'Show'
      black_jack.show_cards
      black_jack.count_sum
    end
  end
end
