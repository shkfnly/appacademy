class AlbumsController < ApplicationController
  before_action :require_login

  def index
    @albums = Album.all
    render :index
  end
  def new
    @album ||= Album.new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = "Success!"
      redirect_to band_url(Band.find(@album.band_id))

    else
      @bands = Band.all
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit 

  end

  def update
    @album = Album.find(params[:id])
    @album.update!(album_params)
    redirect_to album_url(@album)
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end



  private
    def album_params
      params.require(:album).permit(:title, :band_id, :style)
    end
end
