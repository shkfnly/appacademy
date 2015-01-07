class CatsController < ApplicationController


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
    @cat = Cat.new(cat_params)
    @cat.save!
    redirect_to cats_url
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update!(cat_params)
    redirect_to cat_url(@cat)
  end

  private
    def cat_params
      params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
    end
end
