class AlbumsController < ApplicationController
  
  def new
    @album ||= Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Success!"
      redirect_to band_url(Band.find(@album.band_id))
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit

  end

  def update
    @album = Album.find(params[:id])
    @album.update!(band_params)
    redirect_to album_url(@album)
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  private
    def album_params
      params.require(:album).permit(:title, :band_id, :style)
    end
end
