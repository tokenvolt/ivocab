class RussianWord < ActiveRecord::Base
  attr_accessible :entry
  
  has_many :english_words, :through => :translations
  has_many :translations, :dependent => :destroy

  validates :entry, presence: true,
                    uniqueness: true
  
end
