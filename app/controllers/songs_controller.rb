class SongsController < ApplicationController

  def index
    @songs = Song.includes(:user).all.order("created_at desc").page params[:page]
    @hot_songs = Song.hot_songs
    @user_panel = true
  end

  def show
    @song = Song.find(params[:id])
  end

end
