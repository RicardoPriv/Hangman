require_relative "hangman"
require_relative "guess"

module Gameplay
  DICTIONARY_PATH = "./resources/dictionary.txt".freeze
  INCORRECT_GUESSES = 7

  def play
    hangman = Hangman.new
    guess = Guess.new
    initialize_game(hangman, text_from_file(DICTIONARY_PATH))

    puts "\nWelcome to Hangman!"
    puts "Your word: " + hangman.formatted_word(false)

    while guess.get_guess_count < INCORRECT_GUESSES
      puts "\n---------------------------"
      guess.guess_from_user!

      if hangman.check_guess?(guess.get_guess)
        guess.inc_guess_count(-1) # Ensure count only increases for incorrect guesses
        hangman.apply_guess!(guess.get_guess, hangman.check_guess?(guess.get_guess))
        puts "Correct guess!"
      else
        puts "Incorrect guess!"
      end

      puts "\nCurrent word: " + hangman.formatted_word(false)
      puts "Remaining guesses: #{INCORRECT_GUESSES - guess.get_guess_count}"
      
      if hangman.win_game?
        puts "\nCongratulations, you won!"
        return
      end
    end

    puts "\nGame Over! The word was: #{hangman.formatted_word(true)}"
  end

  private

  def initialize_game(hangman, text)
    word = hangman.generate_word(text)
    hangman.initialize_word!(word, false) unless word.nil?
  end

  def text_from_file(file_name)
    return File.exist?(file_name) ? File.readlines(file_name) : []
  end
end
