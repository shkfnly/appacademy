class Api::EntriesController < ApplicationController

  before_action :logged_in?

  def index
    feed = Feed.find_by_user_id(current_user.id).find(params[:feed_id])
    render :json => feed.entries
  end

  private
  def entry_params
    params.
      require(:entry)
      .permit(:guid, :link, :published_at, :title, :json, :feed_id)
  end
end
