class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    #@users = User.all
    @patient_users = User.find_by_sql('SELECT appointments.status, appointments.created_at, appointments.patient_id, appointments.doctor_id, users.first_name, users.last_name
                                      FROM users
                                      INNER JOIN appointments
                                      ON users.id = appointments.patient_id')

    @doctor_users = User.find_by_sql('SELECT appointments.status, appointments.created_at, appointments.patient_id, appointments.doctor_id, users.first_name, users.last_name
                                      FROM users
                                      INNER JOIN appointments
                                      ON users.id = appointments.doctor_id')
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:cover)
    end
end
