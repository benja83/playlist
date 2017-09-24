# frozen_string_literal: true

module Importable
  extend ActiveSupport::Concern

  included do
    def self.import(file)
      Importers::DataWithoutAssociation.new(name).import(file)
    end
  end
end
