class CatsController < ApplicationController
skip_before_action :logged_in, only: [:new, :create, :index, :show]

  def index
    @cats = Cat.all
    render :index
  end


  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    params[:cat][:user_id] = current_user.id
    @cat = Cat.new(cat_params)
    @cat.save!
    redirect_to cats_url
  end

  def edit
    @cat = Cat.find(params[:id])
    if cats_owner
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if cats_owner
      @cat.update!(cat_params)
      redirect_to cat_url(@cat)
    else
      redirect_to cats_url
    end
  end

  private
    def cat_params
      params.require(:cat).permit(:birth_date, :color, :name, :sex, :description, :user_id)
    end

    def cats_owner
      current_user.id == @cat.user_id
    end
end
