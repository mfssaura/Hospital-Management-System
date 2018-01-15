class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :cover, CoverUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :patient_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy
  has_many :images, as: :imageable
end
