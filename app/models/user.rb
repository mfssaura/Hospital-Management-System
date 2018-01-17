class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :cover, CoverUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :patient_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy
  has_many :images, as: :imageable

  def patient?
    self.role == 0
  end

  def doctor?
    self.role == 1
  end

  def self.doc_list
    #User.all.map { |k| [k.first_name, k.id] if k.doctor? }.compact
    User.all.select('id, first_name').where('role = ?', 1)
  end

  def self.pat_list
    #User.all.map { |k| [k.first_name, k.id] if k.patient? }.compact
    User.all.select('id, first_name').where('role = ?', 0)
  end

end
