class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:patient, :doctor]

  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: "patient_id" do
    def future
    end

    def past
    end
  end
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: "doctor_id" do
    def future
      where("appointment_date > current_time", current_time: Time.now)
    end

    def past
      where("appointment_date < current_time", current_time: Time.now)
    end
  end

  has_many :visited_doctors, through: :doctor_appointments
  has_many :patients, through: :patient_appointments

  has_many :notes

  def future_doctor_appointments
    self.
  end

  def future_patient_appointments
    self.patient_appointments.where("appointment_date > current_time", current_time: Time.now)
  end

  def appointments
    result = self.patient_appointments if self.doctor?
    result = self.doctor_appointments if self.patient?
    result
  end
end
