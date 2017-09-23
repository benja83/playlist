# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :user_name, uniqueness: true

  def self.import(file)
    Importers::Users.import(file)
  end
end
