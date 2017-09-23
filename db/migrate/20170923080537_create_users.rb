# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :user_name

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :user_name, unique: true
  end
end
