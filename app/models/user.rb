class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #datetime", "first_name", "last_name", "gender", "string", "date_of_birth", "role",

  validates :date_of_birth, presence: true
  validates :role, presence: true
  # validates :first_name, presence: true, length: { in: 2..30 }, format: { with: /\A[a-zA-Z]+\z/,
  #                                                                         message: "only allows letters" }
  # validates :last_name, presence: true, length: { in: 2..30 }, format: { with: /\A[a-zA-Z]+\z/,
  #                                                                         message: "only allows letters" }
  validates :gender, inclusion: { in: %w(male female),
                                  message: "%{value} is not a valid gender" }



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

  private

    def validate_email
      self.email_confirmed = true
      self.confirm_token = nil
    end

    def set_confirmation_token
      if self.confirm_token.blank?
         self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
