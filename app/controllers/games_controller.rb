require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (1..9).map { |_char| rand(65..90).chr }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @score = ""
    if attempt_valid?(@word, @letters)
      data = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word.downcase}").read)
      if data["found"]
        @score =  "Congratulations! #{@word} is a valid English word!"
      else
        @score =  "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end

  def attempt_valid?(word, letters)
    @letters_count = letters.split.tally.sort_by { |_key, value| -value }.to_h
    @word_count = word.chars.tally.sort_by { |_key, value| -value }.to_h
    @word_count.each do |key, _value|
      return false unless @letters_count.key?(key) && @letters_count[key] >= @word_count[key]
    end
    return true
  end
end
