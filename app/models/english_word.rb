class EnglishWord < ActiveRecord::Base
  attr_accessible :word
  
  has_many :translations
  
  has_many :russian_words, :through => :translations
end
