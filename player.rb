# frozen_string_literal: true

require_relative 'prototype'

class Player < Prototype
  attr_accessor :name, :cards, :balance, :sum

  def initialize(name)
    @name = name
    @cards = []
    @balance = 100
    @sum = 0
  end
end
