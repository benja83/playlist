# frozen_string_literal: true

class Mp3sController < ApplicationController
  def import
    Mp3.import(params[:file])
    redirect_to users_path, notice: 'Mp3 data imported'
  end
end
