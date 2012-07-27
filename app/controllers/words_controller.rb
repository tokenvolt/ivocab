class WordsController < ApplicationController

  def show
    @english_words = EnglishWord.order(:entry)
  end
end
