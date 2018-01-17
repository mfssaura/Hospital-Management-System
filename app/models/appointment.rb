class Appointment < ActiveRecord::Base
  #validates :doctor_id, presence: true
  validates :date, presence: true
  validates :status, presence: true


  belongs_to :patient, class_name: "User"
  belongs_to :doctor, class_name: "User"
  has_many :notes, dependent: :destroy
end
