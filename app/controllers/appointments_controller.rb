class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all
    @pat_app = Appointment.find_by_sql('SELECT *
                                        FROM appointments
                                        INNER JOIN users
                                        ON users.id = appointments.patient_id')
    #@patient_appointments = Appointment.joins(:patient)

    #@doctor_appointments = Appointment.joins(:doctor)

  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.create(appointment_params)
    if @appointment.save
      flash[:notice] = "Appointment Created successfully!"
      redirect_to appointments_path
    else
      flash[:alert] = "Error creating post"
      render 'new'
    end
  end

  def show
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def appointment_params
      patient_id = current_user.id
      params.permit(:date, :status, :doctor_id, :patient_id)
    end

    def notes_params
      user_id = current_user.id
      params.permit(:description, :user_id, :appointment_id)
    end

end
