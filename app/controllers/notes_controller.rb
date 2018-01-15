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

  private

    def notes_params
      params.require(:notes).permit(:description, :appointment_id, :user_id)
    end
end
