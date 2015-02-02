class Api::EntriesController < ApplicationController
  def index
    feed = Feed.find(params[:feed_id])
    render :json => feed.latest_entries
  end
  def show
    render :json => Entry.find(params[:id]);
  end
end
