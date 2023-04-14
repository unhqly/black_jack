# frozen_string_literal: true

require_relative 'prototype'
require_relative 'dealer'
require_relative 'player'
require_relative 'cards'

class Game
  attr_accessor :player, :dealer, :deck, :bank

  def initialize
    puts 'Enter your name please'
    @player = Player.new(gets.chomp)
    @dealer = Dealer.new
    @deck = Cards.new
    @bank = 0
  end

  def refresh
    @deck = Cards.new
    @bank = 0
    player.cards = []
    player.sum = 0
    dealer.cards = []
    dealer.sum = 0
  end

  def show_player_cards
    puts "#{@player.name}'s cards:"
    @player.cards.each { |card| puts card['card'] }
  end

  def show_dealer_cards
    puts "Dealer's cards:"
    @dealer.cards.each { |card| puts card['card'] }
  end

  def subtract_bank
    @player.balance -= 10
    @dealer.balance -= 10
    @bank += 20
  end

  def move(member)
    case member
    when Player
      puts 'Choose your next move ("pass", "add" or "show")'
      choice = gets.chomp

      case choice
      when 'Pass', 'pass'
        puts 'The move goes to the dealer'
        move(dealer)
      when 'Add', 'add'
        if member.cards.size < 3
          member.add_card(deck.get_card)
          puts 'You receive one card'
          if player.cards.size == 3 && dealer.cards.size == 3
            puts 'Both have 3 cards. Time to calculate'
            calculate_results
          else
            show_player_cards
            puts 'The move goes to the dealer'
            move(dealer)
          end
        else
          puts 'You have 3 cards already. The game is over'
          calculate_results
        end
      when 'Show', 'show'
        calculate_results
      end
    when Dealer
      if member.sum < 17
        member.add_card(deck.get_card)
        puts 'The dealer receives one card'
        if player.cards.size == 3 && dealer.cards.size == 3
          puts 'Both have 3 cards. Time to calculate'
          calculate_results
        else
          move(player)
        end
      else
        puts 'The dealer skips a move'
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
      puts 'You have more than 21 points. You lose'
      @dealer.balance += bank
    elsif player.sum > dealer.sum
      puts "You're closer to 21 points than dealer. You won!"
      @player.balance += bank
    elsif player.sum == dealer.sum
      puts 'Draw!'
      @player.balance = bank / 2
      @dealer.balance = bank / 2
    elsif player.sum == 21 && dealer.sum > 21
      puts 'You have 21 points. You won!'
      @player.balance += bank
    else
      puts "Dealer's closer to 21 points than you. You lose"
      @dealer.balance += bank
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
  black_jack.refresh

  puts 'Do you want to play one more time? ("Yes"/"No")'
  choice = gets.chomp
  case choice
  
  when 'Yes', 'yes'
    next
  when 'No', 'no'
    return
  end
end
