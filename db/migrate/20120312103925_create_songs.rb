class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.text :lyrics
      t.text :extra_lyrics
      t.text :introduction
      t.string :songbook_number
      t.string :melody
      t.string :lyrics_author
      t.text :keywords

      t.timestamps
    end
  end
end
