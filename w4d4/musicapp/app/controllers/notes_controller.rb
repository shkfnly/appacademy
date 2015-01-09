class NotesController < ApplicationController
  before_action :require_login

  def new
    @note ||= Note.new
    render :new
  end

  def create
    params[:note][:user_id] = current_user.id
    @note = Note.new(note_params)
    if @note.save
      flash[:notice] = 'Success!'
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  private
    def note_params
      params.require(:note).permit(:user_id, :track_id, :text)
    end
end
