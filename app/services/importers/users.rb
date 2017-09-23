# frozen_string_literal: true

require 'csv'

module Importers
  # import users from csv file with id, first_name, last_name, email, username
  # columns
  class Users
    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        User.create! row.to_hash
      end
    end
  end
end
