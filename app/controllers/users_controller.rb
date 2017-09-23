# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def import
    User.import(params[:file])
    redirect_to users_path, notice: 'User data imported'
  end
end
