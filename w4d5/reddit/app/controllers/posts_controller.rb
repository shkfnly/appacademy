class PostsController < ApplicationController

  before_action :is_author, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    params[:post][:author_id] = current_user.id
    @post = Post.new(post_params)
    @post.sub_ids = params[:post][:sub_ids]
    @subs = Sub.all
    if @post.save
      redirect_to sub_post_url(id: @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
  end

  def update
    @subs = Sub.all
    if @post.update(post_params)
      redirect_to sub_post_url(id: @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

    def is_author
      @post = Post.find(params[:id])
      redirect_to sub_url(params[:sub_ids]) unless current_user.id == @post.author_id
    end

    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
    end

end
