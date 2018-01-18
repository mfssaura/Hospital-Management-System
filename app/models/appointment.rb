class Appointment < ActiveRecord::Base

  validates :date, presence: true
  validates :status, presence: true
  mount_uploader :cover, CoverUploader


  belongs_to :patient, class_name: "User"
  belongs_to :doctor, class_name: "User"
  has_many :notes, dependent: :destroy
  has_many :images, as: :imagable

end
