class RussianWord < ActiveRecord::Base
  attr_accessible :entry
  
  has_many :english_words, :through => :translations
  has_many :translations, :dependent => :destroy
 # has_many :part_of_speeches, :through => :russian_words_pos

  validates :entry, presence: true,
                    length: { maximum: 35 }
end
