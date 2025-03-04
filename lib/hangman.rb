class Hangman
  WORD_LENGTH = { min: 5, max: 12 }.freeze
  LETTER_STATE = Struct.new(:letter, :revealed)

  def initialize
    @word = nil
    @hangman = nil
  end

  def get_word
    return @word
  end

  def get_hangman
    return @hangman
  end

  def set_word(word)
    @word = word
  end

  def set_hangman(hangman)
    @hangman = hangman
  end

  def generate_word(options)
    option_copy = options
    
    while option_copy.length > 0 do
      index = rand(0..option_copy.length)
      word = option_copy[index].chomp
      length = word.length
      return word if length.between?(WORD_LENGTH[:min], WORD_LENGTH[:max])
      option_copy.delete_at(index)
    end
    return nil
  end

  def initialize_word!(word, revealed)
    current_word = word.chars.map { |char| LETTER_STATE.new(char, revealed)}
    set_word(current_word)
  end

  def apply_guess!(guess_letter, letter_index)
    if letter_index
      new_word = get_word
      new_word[letter_index][:revealed] = true
      set_word(new_word)
      return true
    else
      return false
    end
  end

  def check_guess?(guess_letter)
    return get_word.find_index {|letter_state| letter_state[0] == guess_letter && letter_state[1] == false}
  end

  def win_game?
    word = get_word
    word.map do |letter_state|
      return false unless letter_state[:revealed]
    end
    return true
  end

  def formatted_word(overide_reveal)
    word = ""
    
    get_word.each do |word_struct| 
      if overide_reveal or word_struct[:revealed]
        word += word_struct[:letter] + " "
      else
        word += "_ "
      end
    end
    return word.rstrip
  end
end