# frozen_string_literal: true

class Playlisting < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :mp3
end
