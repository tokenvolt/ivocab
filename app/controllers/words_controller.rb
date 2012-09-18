class WordsController < ApplicationController

  def index
    if params[:search]
      @english_words = EnglishWord.search(params[:search])
    else
      @english_words = EnglishWord.order(:entry)
    end
    @total_word_count = EnglishWord.all.length
    show

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    if params[:id]      
      @english_word = EnglishWord.find(params[:id])
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
   
    respond_to do |format|
      if @english_word.save
        format.html { redirect_to list_words_path, 
          notice: " The word '#{@english_word.entry}' was successfully
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
        format.html { redirect_to list_words_path,
          notice: "The word '#{@english_word.entry}'
          was successfully updated."}
      else
        format.html { render action: "edit" }
        format.json { render json: @english_word.errors, status: :unprocessable_entity }
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
