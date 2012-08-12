class Translation < ActiveRecord::Base
  attr_accessible :english_word_id, :russian_word_id
  
  belongs_to :english_word, foreign_key: "english_word_id"
  belongs_to :russian_word, foreign_key: "russian_word_id"
  
end
