class RussianWord < ActiveRecord::Base
  attr_accessible :word
  
  has_many :translations
  
  has_many :english_words, :through => :translations
end
