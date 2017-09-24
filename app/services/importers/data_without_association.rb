# frozen_string_literal: true

module Importers
  class DataWithoutAssociation < Base
    def initialize(model)
      @model = model
      @logger = Logger.new("log/#{model.downcase}_importation.log")
    end

    def import(file)
      logger.info(start_import_message(file))
      importing_csv_from(file) do
        model.camelize.constantize.create! row
      end
    end
  end
end
