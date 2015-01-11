class BandsController < ApplicationController
  before_action :require_login
  
  def index
    @bands = Band.all
    render :index
  end
  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = "Success!"
      redirect_to band_url(@band)
    else
      flash.now[:warning] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update!(band_params)
    render :show
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
    def band_params
      params.require(:band).permit(:name)
    end
end
