class UsersController < ApplicationController
  def index
    #@users = User.all
    @patient_users = User.joins(:doctor_appointments)

    @doctor_users = User.joins(:patient_appointments)
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
