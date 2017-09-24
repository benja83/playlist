# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def import
    Playlist.import(params[:file])
    redirect_to users_path, notice: 'Playlist data imported'
  end
end
