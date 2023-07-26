require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w[a e i o u y]

  def new
    # Generate an array of 10 random letters from the alphabet and store them in @letters
    @letters = []
    5.times { @letters << VOWELS.sample }
    5.times { @letters << (('a'..'z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @grid = params[:letters].split # set of random letters passed via form using hidden_field_tag
    @word = params[:word]

    # Is it an English word?
    @english_word = english_word?(@word) # TRUE or FALSE

    # Is it a valid word according to the grid?
    @valid_word_according_to_grid = valid_according_to_grid?(@word, @grid) # TRUE or FALSE
  end

  private

  # Return TRUE or FALSE whether the word is an English word
  def english_word?(word)
    api = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(api).read
    json = JSON.parse(response)
    json['found']
  end

  # Return TRUE or FALSE whether the word can be formed using letters in the grid
  def valid_according_to_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end
