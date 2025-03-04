# Hangman Game in Ruby

This is a command-line Hangman game written in Ruby. The objective of the game is to guess the hidden word by suggesting letters within a limited number of incorrect attempts.

## Features

- A random word is selected from a dictionary file.
- The word length ranges between **5 to 12** characters.
- Players can guess one letter at a time.
- If the guessed letter is correct, it is revealed in the word.
- If the guessed letter is incorrect, the remaining attempts decrease.
- The game ends when the player either guesses the entire word or runs out of attempts.
- Prevents duplicate guesses.
- Provides clear feedback after each guess.

## Requirements

To run this project, you need to have Ruby installed on your system. You can check if Ruby is installed by running the following command in your terminal:

```bash
ruby -v
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/RicardoPriv/Hangman.git
cd Hangman
```

2. Install dependencies:

```bash
bundle install
```

3. Run the game:

```bash
ruby ./main.rb
```

## Example

```
Welcome to Hangman!
Your word: _ _ _ _ _

Please enter your guess [a to z]: a
Incorrect guess!

Current word: _ _ _ _ _
Remaining guesses: 6

---------------------------

Please enter your guess [a to z]: e
Correct guess!

Current word: _ e _ _ _
Remaining guesses: 6

```

## Game Flow

1. The game generates a random word.
2. The player is prompted to enter a letter.
3. If the letter is correct, it is revealed in the word.
4. If the letter is incorrect, the number of remaining guesses decreases.
5. The game continues until the player wins or loses.
6. At the end, the correct word is displayed.

## Files

- **main.rb**: The entry point of the game.
- **lib/gameplay.rb**: Contains the main game logic.
- **lib/hangman.rb**: Manages the word selection and game rules.
- **lib/guess.rb**: Handles player input and guess tracking.
- **resources/dictionary.txt**: Contains the list of words used in the game.
- **Gemfile**: Specifies the dependencies required for the project.