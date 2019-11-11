require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { (("A".."Z").to_a).sample }
  end

  def score
    @letters = params[:letters].split
    @input = (params[:input] || "").upcase
    @included = included?(@input, @letters)
    @english_input = english_input?(@input)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letter.count(letter) }
  end

  def english_input?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
