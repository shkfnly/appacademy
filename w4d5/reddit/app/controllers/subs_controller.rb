class SubsController < ApplicationController
  before_action :require_mod, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def new
    @sub = Sub.new
  end

  def create
    params[:sub][:moderator_id] = current_user.id
    @sub = Sub.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.delete
    redirect_to subs_url
  end



  private

  def require_mod
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless @sub.moderator_id == current_user.id
  end
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

end
