# frozen_string_literal: true

require 'csv'

BYTE_ORDER_MARK = "\xEF\xBB\xBF"

class PlaylistImporter
  def initialize
    @logger = Logger.new('log/playlists_importation.log')
  end

  def import(file)
    logger.info(start_import_message(file))

    CSV.foreach(file.path, csv_options) do |csv_row|
      begin
        @row = csv_row.to_hash.with_indifferent_access
        playlist = create_playlist!
        associate_mp3_to(playlist)
      rescue StandardError => error
        logger.error(error_message_from(error))
        next
      end
    end
  end

  private

  attr_reader :logger, :row

  def create_playlist!
    Playlist.create!(id: row[:id], user: User.find(row[:user_id]))
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
    row[:mp3_ids].split(',').map(&:to_i)
  end

  def csv_options
    { headers: true,
      encoding: 'UTF-8',
      header_converters: sanitize_field,
      converters: sanitize_field }
  end

  def error_message_from(error)
    "[ERROR] #{row} have an error #{error.class}: #{error.message} "\
    'You must take a look to the original file'
  end

  def start_import_message(file)
    "[INFO] Starting to import #{file.inspect} in playlists table"
  end

  def sanitize_field
    lambda do |header|
      header.downcase.sub(BYTE_ORDER_MARK.dup.force_encoding('UTF-8'), '')
            .gsub('\r', '')
    end
  end
end
