class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @appointments = Appointment.all.where.not(cover: nil)
    @users = User.all.where.not(cover: nil)
    image = []
    @appointments.each do |app|
      @image.cover = app.cover
      @image.imageable_id = app.appointment_id
      @image.imagable_type = "appointment"
    end

    @image = array

    @users.each do |user|
      @image.cover = user.cover
      @image.imageable_id = user.user_id
      @image.imagable_type = "user"
    end

  end

  def show
    @appointment = Appointment.find(params[:id])
    @user = User.find(params[:id])
  end
end
