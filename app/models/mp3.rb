# frozen_string_literal: true

class Mp3 < ActiveRecord::Base
  def self.import(file)
    Importers::Mp3s.import(file)
  end
end
