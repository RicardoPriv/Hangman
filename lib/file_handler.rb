require "json"

module FileHandler
  SAVES_DIRECTORY = "./saves/".freeze

  def self.load_hangman_game(filename)
    filename = SAVES_DIRECTORY + filename
    return nil unless File.exist?(filename)

    file_content = File.read(filename)
    JSON.parse(file_content, symbolize_names: true)
  end

  def self.save_hangman_game(word, has_guessed, guess_count)
    print "\nPlease enter filename to save to (will create file if doesn't exist) : "
    filename = SAVES_DIRECTORY + gets.chomp + ".json"

    File.open(filename, "w") do |file|
      game_state = { word: word, has_guessed: has_guessed, guess_count: guess_count }
      file.write(JSON.generate(game_state))
      puts "File saved successfully"
    end
  end

  def self.list_save_games
    Dir.exist?(SAVES_DIRECTORY) ? Dir.children(SAVES_DIRECTORY) : []
  end
end
