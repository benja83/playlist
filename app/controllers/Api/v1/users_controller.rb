# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        # users = User.all
        render locals: { users: User.all }
        # @users = User.all
      end
    end
  end
end
