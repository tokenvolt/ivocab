class EnglishWord < ActiveRecord::Base
  attr_accessible :entry, :russian_words_attributes
  
  has_many :russian_words, :through => :translations, uniq: true
  has_many :translations, :dependent => :destroy
#  has_many :part_of_speeches, :through => :english_words_pos
  
  accepts_nested_attributes_for :russian_words, :reject_if => lambda { |a| a[:entry].blank? }, allow_destroy: true
  
  scope :search, lambda { |query| where("entry LIKE ?", "%#{query}%") }

  validates :entry, presence: true,
                    uniqueness: true,
                    length: { maximum: 35 }

  before_save :check_russian_translations

  def check_russian_translations
    if self.russian_words
      self.russian_words = self.russian_words.map do |russian_word|
        RussianWord.find_or_create_by_entry(russian_word.entry)
      end
    end    
  end

end
