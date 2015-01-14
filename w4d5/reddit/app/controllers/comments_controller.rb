class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
    
  end

  def create
    params[:comment][:author_id] = current_user.id
    params[:comment][:post_id] = @post_id
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = 'Success'
      redirect_to sub_post_url(id: @comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content, :author_id, :post_id)
  end


end
