# frozen_string_literal: true

require 'csv'

module Importers
  class Base
    BYTE_ORDER_MARK = "\xEF\xBB\xBF"

    private

    attr_reader :row, :logger, :model

    def importing_csv_from(file)
      CSV.foreach(file.path, csv_options) do |csv_row|
        begin
          @row = csv_row.to_hash
          yield
        rescue ActiveRecord::UnknownAttributeError => error
          logger.error(error_message_from(error))
          next
        end
      end
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
      "[INFO] Starting to import #{file.inspect} in #{model.pluralize} table"
    end

    def sanitize_field
      lambda do |header|
        header.downcase.sub(BYTE_ORDER_MARK.dup.force_encoding('UTF-8'), '')
              .gsub('\r', '')
      end
    end
  end
end
