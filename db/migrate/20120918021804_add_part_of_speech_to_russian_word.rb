class AddPartOfSpeechToRussianWord < ActiveRecord::Migration
  def change
    add_column :russian_words, :part_of_speech, :string
  end
end
