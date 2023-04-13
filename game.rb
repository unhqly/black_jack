require_relative 'prototype'
require_relative 'dealer'
require_relative 'player'
require_relative 'cards'

class Game
  attr_accessor :player, :dealer, :deck, :bank

  def initialize
    puts "Enter your name please"
    @player = Player.new(gets.chomp)
    @dealer = Dealer.new
    @deck = Cards.new
    @bank = 0
  end

  def refresh
    @deck = Cards.new
    player.cards = []
    player.sum = 0
    dealer.cards = []
    dealer.sum = 0
  end

  def show_player_cards
    puts "#{@player.name}'s cards:"
    @player.cards.each { |card| puts card['card']}
  end

  def show_dealer_cards
    puts "Dealer's cards:"
    @dealer.cards.each { |card| puts card['card']}
  end

  def subtract_bank
    @player.balance -= 10
    @dealer.balance -= 10
    @bank += 20
  end

  def move(member)
    if member.is_a?(Player)
      puts 'Choose your next move'
      choice = gets.chomp

      case choice
      when 'Pass'
        puts "The move goes to the dealer"
        move(dealer)
      when 'Add'
        if member.cards.size < 3
          member.add_card(deck.get_card)
          puts "You receive one card"
          show_player_cards
          puts "The move goes to the dealer"
          move(dealer)
        else
          puts "You have 3 cards already. The game is over"
          calculate_results
        end
      when 'Show'
        calculate_results
      end
    elsif member.is_a?(Dealer)
      if member.sum < 17
        member.add_card(deck.get_card)
        puts "The dealer receives one card"
        move(player)
      else
        puts "The dealer skips a move"
        move(player)
      end
    end
  end

  def calculate_results
    show_player_cards
    puts "#{player.name}'s sum = #{player.sum}"
    show_dealer_cards
    puts "Dealer's sum = #{dealer.sum}"
    if player.sum > 21
      puts "You have more than 21 points. You lose"
      @dealer.balance += bank
      @bank = 0
    elsif player.sum > dealer.sum
      puts "You're closer to 21 points than dealer. You won!"
      @player.balance += bank
      @bank = 0
    elsif player.sum == dealer.sum
      puts "Draw!"
      @player.balance = bank/2
      @dealer.balance = bank/2
      @bank = 0
    else 
      puts "Dealer's closer to 21 points than you. You lose"
      @dealer.balance += bank
      @bank = 0
    end
    show_balance
  end

  def show_balance
    puts "#{player.name}'s balance = #{player.balance}"
    puts "Dealer's balance = #{dealer.balance}"
  end
end

black_jack = Game.new
loop do
  black_jack.subtract_bank
  2.times { black_jack.player.add_card(black_jack.deck.get_card) }
  2.times { black_jack.dealer.add_card(black_jack.deck.get_card) }
  black_jack.show_player_cards
  puts "Dealer's cards: *****"
  black_jack.move(black_jack.player)
  black_jack.calculate_results
  black_jack.refresh

  puts "Do you want to play one more time?"
  if gets.chomp == "Yes"
    next
  else
    return
  end
end
