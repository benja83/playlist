# frozen_string_literal: true
class CreatePlaylistings < ActiveRecord::Migration
  def change
    create_table :playlistings do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :mp3, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
