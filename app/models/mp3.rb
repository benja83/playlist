# frozen_string_literal: true

class Mp3 < ActiveRecord::Base
  include Importable

  has_many :playlistings
  has_many :playlists, through: :playlistings
end
