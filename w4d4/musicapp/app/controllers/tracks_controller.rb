class TracksController < ApplicationController
    before_action :require_login
  
  def new
    @track ||= Track.new
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = 'Success!'
      redirect_to album_url(Album.find(@track.album_id))
    else
      @albums = Album.all
      flash.now[:danger] = @track.errors.full_messages
      render :new
    end

  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update!(track_params)
    render :show
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @track2 = @track
    @track.delete
    redirect_to album_url(Album.find(@track2.album_id))
  end

  private
    def track_params
      params.require(:track).permit(:name, :album_id, :distrib, :lyrics)
    end
end
