class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    render json: @comments
  end

  def create
    @commentable = find_commentable
    insert_params = comment_params
    insert_params[:commentable_type] = @commentable.class.to_s
    insert_params[:commentable_id] = @commentable.id
    @comment = Comment.new(insert_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: 404
    end
  end



private

  def comment_params
    params[:comment].permit(:content, :commentable_type, :commentable_id)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
