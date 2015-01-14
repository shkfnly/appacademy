class CommentsController < ApplicationController

  def create
    params[:comment][:author_id] = current_user.id
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.commentable
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :author_id, :commentable_id, :commentable_type)
    end
end
