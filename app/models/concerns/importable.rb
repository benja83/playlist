# frozen_string_literal: true

module Importable
  extend ActiveSupport::Concern

  included do
    def self.import(file)
      Importer.new(name).import(file)
    end
  end
end
