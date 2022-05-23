require "json"
require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..9]
  end

  def score
    @score = 0
    letters = params[:grid].split("")
    @word = params[:word]
    @valid = valid?(@word)
    input_word = @word.split("").all? do |letter|
    # input_word.each do |letter|
      a = letters.count(letter)
      b = input_word.count(letter)
      # raise
      if a <= b && a.positive?
        @score += 1
      else
        @valid = false
      end
    end
    return @score if @valid
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end
end
