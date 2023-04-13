class Cards
  
  attr_reader :available_cards, :equivalents

  def initialize
    @available_cards = ['A<3', 'K<3', 'Q<3', 'J<3', '10<3', '9<3', '8<3', '7<3', '6<3', '5<3', '4<3', '3<3', '2<3',
                        'A+', 'K+', 'Q+', 'J+', '10+', '9+', '8+', '7+', '6+', '5+', '4+', '3+', '2+',
                        'A^', 'K^', 'Q^', 'J^', '10^', '9^', '8^', '7^', '6^', '5^', '4^', '3^', '2^',
                        'A<>', 'K<>', 'Q<>', 'J<>', '10<>', '9<>', '8<>', '7<>', '6<>', '5<>', '4<>', '3<>', '2<>']
    @equivalents = {'a' => 11, 'k' => 10, 'q' => 10, 'j' => 10, '1' => 10, '9' => 9, '8' => 8, 
                    '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2}
  end

  def get_card
    number = rand(available_cards.size)
    card = available_cards.delete_at(number)
    {'card' => card, 'equivalent' => equivalents[card.downcase.chars.first]}
  end
end