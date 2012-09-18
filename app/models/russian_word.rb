class RussianWord < ActiveRecord::Base
  attr_accessible :entry, :part_of_speech
  
  has_many :english_words, :through => :translations
  has_many :translations, :dependent => :destroy

  PART_OF_SPEECH = %w{verb noun adjective adverb pronoun preposition conjunciton interjection}

  validates :entry, presence: true,
                    length: { maximum: 35 }
end
