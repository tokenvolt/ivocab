class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :english_word
      t.references :russian_word
      
      t.timestamps
    end
  end
end
