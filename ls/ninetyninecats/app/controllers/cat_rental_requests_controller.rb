class CatRentalRequestsController < ApplicationController

  def approve
    @request = CatRentalRequest.find(params[:id])
    if @request.approve!
      redirect_to cat_url(@request.cat)
    else
      redirect_to cat_url(@request.cat)
    end
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
  end

  def index
    render json: CatRentalRequest.all
  end

  def show
    render json: CatRentalRequest.find(params[:id])
  end

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)

    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render json: @request.errors
    end
  end

  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
