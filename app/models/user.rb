# frozen_string_literal: true
class User < ActiveRecord::Base
  include Importable

  has_many :playlists

  validates :email, uniqueness: true
  validates :user_name, uniqueness: true
end
