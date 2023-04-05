require_relative 'dealer'
require_relative 'player'
require_relative 'cards'

class Game

  def initialize
    puts "Enter your name please"
    @player = Player.new(gets.chomp)
    @dealer = Dealer.new
    @cards = Cards.new
  end

  def throw_cards
    2.times do
      number = rand(@cards.available_cards.size)
      @player.cards << @cards.available_cards[number]
      @cards.available_cards.delete_at(number)
    end

    puts "#{@player.name}'s cards:"
    @player.cards.each { |card| puts card}

    2.times do
      number = rand(@cards.available_cards.size)
      @dealer.cards << @cards.available_cards[number]
      @cards.available_cards.delete_at(number)
    end

    puts "Dealers cards: *******"

#    puts "Available cards"
#    @cards.available_cards.each { |card| puts card }
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
        @player.sum += @cards.equivalents[number.downcase]
      end
    end

    puts "#{@player.name}'s sum = #{@player.sum}"
  end
end

black_jack = Game.new
black_jack.throw_cards
black_jack.count_sum
