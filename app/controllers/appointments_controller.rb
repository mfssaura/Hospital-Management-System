class AppointmentsController < ApplicationController

  before_action :authenticate_user!

  def index
    @my_apps = Appointment.where(doctor_id: current_user.id).paginate(:page => params[:page], :per_page => 5) if current_user.doctor?
    @my_apps = Appointment.where(patient_id: current_user.id).paginate(:page => params[:page], :per_page => 5) if current_user.patient?
  end

  def user_photo
    @all_users_pics = User.all.where.not(cover: nil)
  end

  def disease_photo
    @all_disease_pics = Appointment.all.where.not(cover: nil)
  end

  def archives
    # show past appointment records which are 10 years older
    
    time_range = (Time.now - 10.year)..Time.now
    @past_appointments = Appointment.all.where(date: time_range).paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @appointment = Appointment.new
    @note = Note.new

    @all_doctors = User.doc_list          #Get all doctors
    @all_patients = User.pat_list         #Get all patients
  end

  def create
    @appointment = Appointment.create(appointment_params)
    @note = @appointment.notes.create(notes_params)
    @note.user_id = current_user.id
    if current_user.patient?
      @appointment.patient_id = current_user.id
    else
      @appointment.doctor_id = current_user.id
    end

    if @appointment.save && @note.save
      flash[:notice] = "Appointment Created successfully!"
      redirect_to appointments_path
    else
      flash[:alert] = "Error creating appointment"
      render 'new'
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @note = Appointment.last.notes
    curr_id = current_user.id
    @my_notes = Note.where('user_id = ?', curr_id)
  end


  def edit
    @appointment = Appointment.find(params[:id])
    @note = @appointment.notes.last
    @all_doctors = User.doc_list
    @all_patients = User.pat_list
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update(appointment_params) && @appointment.notes.last.update(notes_params)
      flash[:notice] = "Appointments updated"
      redirect_to appointments_path
    else
      render 'edit'
    end
  end

  def destroy

    @appointment = Appointment.find(params[:id])
    if @appointment.destroy
      flash[:notice] = "Deleted successfully!"
      redirect_to appointments_path
    else
      flash[:alert] = "Unable to delete"
    end
  end

  private

    def appointment_params
      params.require(:appointment).permit(:date, :status, :doctor_id, :patient_id, :cover)
    end

    def notes_params
      params[:appointment].require(:notes).permit(:description)
    end

end
