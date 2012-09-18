class EnglishWord < ActiveRecord::Base
  attr_accessible :entry, :russian_words_attributes
  
  has_many :russian_words, :through => :translations, uniq: true
  has_many :translations, :dependent => :destroy
   
  accepts_nested_attributes_for :russian_words, :reject_if => lambda { |a| a[:entry].blank? }, allow_destroy: true
  
  scope :search, lambda { |query| where("entry LIKE ?", "%#{query}%") }

  validates :entry, presence: true,
                    uniqueness: true,
                    length: { maximum: 35 }

  before_save :check_russian_translations

  def check_russian_translations
    if self.russian_words
      self.russian_words = self.russian_words.map do |russian_word|
        RussianWord.find_or_initialize_by_entry_and_part_of_speech(russian_word.entry, russian_word.part_of_speech)
      end
    end    
  end

end
