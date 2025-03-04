require_relative "hangman"
require_relative "guess"
require_relative "file_handler"

module Gameplay
  DICTIONARY_PATH = "./resources/dictionary.txt".freeze
  INCORRECT_GUESSES = 7
  EXIT_CONDITION = "1"

  def self.play
    hangman = Hangman.new
    guess = Guess.new

    start_input = startup
    return if start_input == EXIT_CONDITION

    unless start_input == "n"
      game_state = FileHandler.load_hangman_game(start_input + ".json")
      hangman.set_word(game_state[:word])
      game_state[:has_guessed].each { |letter| guess.add_has_guessed(letter) }
      guess.inc_guess_count(game_state[:guess_count])
    else
      initialize_game!(hangman, guess, text_from_file(DICTIONARY_PATH))
    end

    puts "\nWelcome to Hangman!"
    puts "Your word: " + hangman.formatted_word(false)

    while guess.get_guess_count < INCORRECT_GUESSES
      puts "\n---------------------------"
      guess.guess_from_user!(EXIT_CONDITION)
      return if guess.get_guess == EXIT_CONDITION

      if guess.get_guess == "save"
        FileHandler.save_hangman_game(hangman.get_word, guess.get_has_guessed, guess.get_guess_count)
        puts "\nGame saved!"
        return
      elsif hangman.check_guess?(guess.get_guess)
        guess.inc_guess_count(-1) # Ensure count only increases for incorrect guesses
        hangman.apply_guess!(guess.get_guess)
        puts "\nCorrect guess!"
      else
        puts "\nIncorrect guess!"
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

  def self.initialize_game!(hangman, guess, text)
    word = hangman.generate_word(text)
    hangman.initialize_word!(word, false) unless word.nil?
    guess = Guess.new
  end

  def self.text_from_file(file_name)
    return File.exist?(file_name) ? File.readlines(file_name) : []
  end

  def self.startup
    begin
      print "\nWelcome, would you like to load a save [Y/n]: "
      input = gets.chomp
    end until ["Y", "n", EXIT_CONDITION].include?(input)

    return input if input == "n" || input == EXIT_CONDITION

    save_games = FileHandler.list_save_games.map { |file| file.gsub(".json", "") }
    puts "\nAvailable save games: #{save_games.join(', ')}"

    chosen_game = nil
    until save_games.include?(chosen_game) || chosen_game == EXIT_CONDITION
      print "\nPlease type the name of a valid file from the list (or #{EXIT_CONDITION} to exit): "
      chosen_game = gets.chomp
    end

    return chosen_game
  end
end
