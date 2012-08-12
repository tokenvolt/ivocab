class EnglishWord < ActiveRecord::Base
  attr_accessible :entry, :russian_words_attributes
  
  has_many :russian_words, :through => :translations
  has_many :translations, :dependent => :destroy
  
  accepts_nested_attributes_for :russian_words, :reject_if => lambda { |a| a[:entry].blank? }, allow_destroy: true
  
  validates :entry, presence: true,
                    uniqueness: true,
                    length: { maximum: 35 }
end
