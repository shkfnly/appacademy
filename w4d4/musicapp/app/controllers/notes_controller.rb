class NotesController < ApplicationController
  before_action :require_login
  before_action :note_owner_or_admin, only: [:edit, :update, :destroy]

  def new
    @note ||= Note.new
    render :new
  end

  def create
    params[:note][:user_id] = current_user.id
    @note = Note.new(note_params)
    if @note.save
      flash[:success] = 'Success!'
      redirect_to track_url(@note.track_id)
    else
      flash.now[:danger] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def edit
    render :edit
  end

  def update
    @note.update(note_params)
    redirect_to track_url(@note.track)
  end

  def destroy
    @note.destroy
    redirect_to track_url(@note.track)
  end

  def note_owner_or_admin
      @note = Note.find(params[:id])
      unless @note.user_id == current_user.id || current_user.admin
        redirect_to track_url(@note.track)
      end
  end


  private
    def note_params
      params.require(:note).permit(:user_id, :track_id, :text)
    end


end
