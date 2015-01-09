class CatRentalRequestsController < ApplicationController
  

  def approve
    @request = CatRentalRequest.find(params[:id])
    if cats_owner
      @request.approve!
    end
    redirect_to cats_url
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    if cats_owner
      @request.deny!
    end
    redirect_to cat_url(@request.cat)
  end

  def index
    render json: CatRentalRequest.all
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    redirect_to cat_url(@request.cat_id)
  end

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    params[:cat_rental_request][:user_id] = current_user.id
    @request = CatRentalRequest.new(request_params)

    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      render json: @request.errors
    end
  end

  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :user_id)
  end

  def cats_owner
    current_user.id == @request.cat.user_id
  end
end
