class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def new
    @note = Note.new
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @note = @appointment.notes.create(notes_params)
    if @note.save
      flash['notice'] = 'Created successfully'
      redirect_to edit_appointment_path(@note)
    else
      flash['notice'] = 'Opps'
      render 'new'
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @note = @appointment.notes.last
  end

  def show
    @appointment = Appointment.find(params[:id])
    @my_notes = Note.where('user_id = ?', current_user.id)
  end

  def update
  end

  def destroy
  end

  private
    def notes_params
      params.require(:note).permit(:description)
    end

end
