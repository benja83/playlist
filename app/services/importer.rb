# frozen_string_literal: true

require 'csv'

BYTE_ORDER_MARK = "\xEF\xBB\xBF"

class Importer
  def initialize(model)
    @model = model
    @logger = Logger.new("log/#{model.downcase}_importation.log")
  end

  def import(file)
    logger.info(start_import_message(file))

    CSV.foreach(file.path, csv_options) do |row|
      begin
        @row = row.to_hash
        model.camelize.constantize.create! @row
      rescue StandardError => error
        logger.error(error_message_from(error))
        next
      end
    end
  end

  private

  attr_reader :model, :logger

  def csv_options
    { headers: true,
      encoding: 'UTF-8',
      header_converters: sanitize_field,
      converters: sanitize_field }
  end

  def error_message_from(error)
    "[ERROR] #{@row} have an error: #{error.message} "\
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
