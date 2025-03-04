class Hangman
  WORD_LENGTH = { min: 5, max: 12 }.freeze

  def initialize
    @word = nil
  end

  def get_word
    @word
  end

  def set_word(word)
    @word = word
  end

  def generate_word(options)
    option_copy = options.dup

    until option_copy.empty?
      index = rand(0..option_copy.length - 1)
      possible_word = option_copy[index].chomp
      return possible_word if possible_word.length.between?(WORD_LENGTH[:min], WORD_LENGTH[:max])

      option_copy.delete_at(index)
    end

    ''
  end

  def initialize_word!(word, revealed)
    current_word = word.chars.map { |char| { letter: char, revealed: revealed } }
    set_word(current_word)
  end

  def apply_guess!(guess_letter)
    get_word.each_with_index do |letter, index|
      get_word[index][:revealed] = true if letter[:letter] == guess_letter && !letter[:revealed]
    end
  end

  def check_guess?(guess_letter)
    get_word.any? { |letter| letter[:letter] == guess_letter && !letter[:revealed] }
  end

  def win_game?
    get_word.all? { |letter_state| letter_state[:revealed] }
  end

  def formatted_word(overide_reveal)
    get_word.map { |word_struct| overide_reveal || word_struct[:revealed] ? word_struct[:letter] : '_' }.join(' ')
  end
end
