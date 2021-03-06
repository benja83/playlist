# frozen_string_literal: true

class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :playlistings, dependent: :destroy
  has_many :playlists, through: :playlistings

  after_create :put_default_name

  def put_default_name
    self.name = "#{id}_playlist_#{user.id}"
    save!
  end

  def mp3_ids
    playlistings.pluck(:mp3_id)
  end

  def self.import(file)
    Importers::Playlists.new.import(file)
  end
end
