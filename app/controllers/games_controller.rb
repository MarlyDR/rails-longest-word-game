require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end


  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)

    @result = if word['found'] == true && included_word
                "Congratulations! #{@word.upcase} is a valid English word!"
              else
                "Sorry but #{@word.upcase} is not valid with the letters proposed."
              end
  end

  def included_word
    letters = params[:letters].chars
    word = @word.upcase.chars
    word.each do |letter|
      if letters.index(letter).nil?
        return false
      else
        index = word.index(letter)
        letters.delete(index)
      end
    end
  end

end
