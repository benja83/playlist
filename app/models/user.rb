class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def self.import(file)
    Importers::Users.import(file)
  end
end
