class CreateRussianWords < ActiveRecord::Migration
  def change
    create_table :russian_words do |t|
      t.string :entry

      t.timestamps
    end
  end
end
