class Guess
  def initialize
    @guess = nil
    @has_guessed = []
    @guess_count = 0
  end

  def get_guess
    @guess
  end

  def get_has_guessed
    @has_guessed
  end

  def get_guess_count
    @guess_count
  end

  def set_guess(guess)
    @guess = guess
  end

  def add_has_guessed(guess)
    @has_guessed.push(guess)
  end

  def inc_guess_count(amount)
    @guess_count += amount
  end

  def guess_from_user!
    puts "\nPlease enter your guess [a to z]: "
    
    loop do
      guess = gets.chomp.downcase
      
      if get_has_guessed.include?(guess)
        puts "Already guessed '#{guess}'. Try another letter."
      elsif guess.length == 1 && guess.match?(/[a-z]/)
        add_has_guessed(guess)
        inc_guess_count(1)
        set_guess(guess)
        return
      else
        puts "Invalid input. Enter a single letter [a-z]:"
      end
    end
  end
end
