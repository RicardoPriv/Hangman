require_relative "hangman"


module Gameplay
  DICTIONARY_PATH = "./resources/dictionary.txt".freeze
  INCORRECT_GUESSES = 7

  def play
    hangman = Hangman.new
    initialize_game(hangman, text_from_file(DICTIONARY_PATH))
    puts hangman.formatted_word(true)
    
    INCORRECT_GUESSES.times do
      guess = get_input
      hangman.apply_guess!(guess)
      puts hangman.formatted_word(false)
    end
    
  end

  def initialize_game(hangman, text) 
    word = hangman.generate_word(text)
    hangman.initialize_word!(word, false) unless word.nil?
  end

  def text_from_file(file_name)
    text = ""
    if File.exist?(file_name)
      text = File.readlines(file_name)
    end
    return text
  end

  def get_input
    print "\nPlease enter your guess [a to z]: "
    guess = ""
    until guess.length == 1 and guess.ord.between?(97, 122) do
      guess = gets.chomp
      return guess if guess.length == 1 and guess.ord.between?(97, 122)
      print "Invalid guess, please enter a valid guess [a to z]:"
    end
  end
end