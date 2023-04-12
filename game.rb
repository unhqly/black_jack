require_relative 'prototype'
require_relative 'dealer'
require_relative 'player'
require_relative 'cards'

class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    puts "Enter your name please"
    @player = Player.new(gets.chomp)
    @dealer = Dealer.new
    @deck = Cards.new
  end

  def show_cards
    puts "#{@player.name}'s cards:"
    @player.cards.each { |card| puts card}

    puts "Dealer's cards:"
    @dealer.cards.each { |card| puts card}
  end

  def count_sum
    @player.cards.each do |card|
      number = card.chars.first
#      puts "Number = #{number}, #{number.class}"
      if number == "A"
        if @player.sum > 10
          @player.sum += 1
        else
          @player.sum += 11
        end
      else
#        puts "Hash of equivalents: #{@cards.equivalents}"
#        puts "Equivalent = #{@cards.equivalents[:"#{number.downcase}"]}"
        @player.sum += @deck.equivalents[number.downcase]
      end
    end

    @dealer.cards.each do |card|
      number = card.chars.first
      if number == "A"
        if @dealer.sum > 10
          @dealer.sum += 1
        else
          @dealer.sum += 11
        end
      else
        @dealer.sum += @deck.equivalents[number.downcase]
      end
    end

    puts "#{@player.name}'s sum = #{@player.sum}"
    puts "Dealer's sum = #{@dealer.sum}"
  end

  def subtract_bank
    @player.bank -= 10
    @dealer.bank -= 10
  end
end

black_jack = Game.new
black_jack.subtract_bank
2.times { black_jack.player.add_card(black_jack.deck) }
2.times { black_jack.dealer.add_card(black_jack.deck) }
black_jack.show_cards

loop do
  black_jack.player.move(black_jack.deck)
end
