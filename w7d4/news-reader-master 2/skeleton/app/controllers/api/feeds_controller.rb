class Api::FeedsController < ApplicationController

  before_action :logged_in?

  def index
    render :json => Feed.find_by_user_id(current_user.id)
  end

  def show
    render :json => Feed.find_by_user_id(current_user.id).find(params[:id]), include: :latest_entries
  end

  def new
    render :json => Feed.new
  end

  def create
    feed = Feed.find_by_user_id(current_user.id).find_or_create_by_url(feed_params[:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  def destroy
    feed = Feed.find_by_user_id(current_user.id).find(params[:id])
    feed.destroy
    render :json => Feed.all
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
