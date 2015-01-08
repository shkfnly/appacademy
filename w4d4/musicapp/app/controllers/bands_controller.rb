class BandsController < ApplicationController
  
  def new
    @band ||= Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notice] = "Success!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    render json: @band
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update!(band_params)
  end

  private
    def band_params
      params.require(:band).permit(:name)
    end
end
