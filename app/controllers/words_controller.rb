class WordsController < ApplicationController

  def index
    @english_words = EnglishWord.order(:entry)
    @total_word_count = EnglishWord.all.length
    if params[:id]      
      @english_word = EnglishWord.find(params[:id])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @english_word = EnglishWord.new
    @english_word.russian_words.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @english_word }
    end
  end
  
  def create
    @english_word = EnglishWord.new(params[:english_word])
    @english_word.russian_words.each do |russian_word|
      repeated_russian_word = RussianWord.where(entry: russian_word.entry) 
      unless repeated_russian_word.blank?
        @english_word.translations.build(russian_word_id: repeated_russian_word.first.id)
        russian_word.destroy
      end
    end
    
    respond_to do |format|
      if @english_word.save
        @english_word.russian_words(true)
        format.html { redirect_to list_words_path, notice: " The word '#{@english_word.entry}' was successfully
        added to the vocabulary" }
      else
        format.html { render action: "new" }
        format.json { render json: @english_word.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @english_word = EnglishWord.find(params[:id])
  end
  
  def update
    @english_word = EnglishWord.find(params[:id])   
    
    respond_to do |format|
      if @english_word.update_attributes(params[:english_word])
        format.html { redirect_to list_words_path, notice: "The word #{@english_word.entry} was successfully updated."}
      else
        format.html { redirect_to edit_word_path }

      end
    end
  end
  
  def destroy
    @english_word = EnglishWord.find(params[:id])
    @english_word.destroy

    respond_to do |format|
      format.html { redirect_to list_words_path }
      format.js
    end
  end
end
