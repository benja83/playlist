# frozen_string_literal: true

require 'csv'

module Importers
  # import users from csv file with id, first_name, last_name, email, username
  # columns

  BYTE_ORDER_MARK = "\xEF\xBB\xBF"

  class Mp3s
    class << self
      def import(file)
        CSV.foreach(file.path, csv_options) do |row|
          begin
            @row = row.to_hash
            Mp3.create! @row
          rescue StandardError => error
            logger.error(error_message_from(error))
            next
          end
        end
      end

      private

      def csv_options
        { headers: true,
          encoding: 'UTF-8',
          header_converters: sanitize_field,
          converters: sanitize_field }
      end

      def error_message_from(error)
        "[ERROR] #{@row} have an error: #{error.message}. "\
        'You must take a look to the original file'
      end

      def logger
        Logger.new('log/mp3_importation.log')
      end

      def sanitize_field
        lambda do |header|
          header.downcase.sub(BYTE_ORDER_MARK.dup.force_encoding('UTF-8'), '')
                .gsub('\r', '')
        end
      end
    end
  end
end
