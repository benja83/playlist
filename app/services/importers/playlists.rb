# frozen_string_literal: true

module Importers
  class Playlists < Base
    def initialize
      @logger = Logger.new('log/playlist_importation.log')
      @model = 'playlist'
    end

    def import(file)
      logger.info(start_import_message(file))

      importing_csv_from(file) do
        playlist = create_playlist!
        associate_mp3_to(playlist)
      end
    end

    private

    def create_playlist!
      Playlist.create!(id: row['id'], user: User.find(row['user_id']))
    end

    def associate_mp3_to(playlist)
      mp3_ids.map do |id|
        begin
          playlist.playlistings.create!(mp3: Mp3.find(id))
        rescue ActiveRecord::RecordNotFound => error
          logger.error(error_message_from(error))
          next
        end
      end
    end

    def mp3_ids
      row['mp3_ids'].split(',').map(&:to_i)
    end
  end
end
