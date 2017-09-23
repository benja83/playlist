# frozen_string_literal: true
class CreateMp3s < ActiveRecord::Migration
  def change
    create_table :mp3s do |t|
      t.string :title
      t.string :interpret
      t.string :album
      t.integer :track
      t.integer :year
      t.string :genre

      t.timestamps null: false
    end

    add_index :mp3s, :title
  end
end
