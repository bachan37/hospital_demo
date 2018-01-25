class Appointment < ActiveRecord::Base
  attr_accessor :note
       
  enum status: [:pending, :completed, :cancelled]
  
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  validates :doctor_id, presence: true
  validates :note, presence: true
  validates :appointment_date, presence: true
  validate :validate_appointment_date

  has_many :notes
  

  def validate_appointment_date
    self.errors.add(:appointment_date, 'can not be left as blank') and return if self.appointment_date.blank?
    self.errors.add(:appointment_date, "plz add after 1 hour") and return if self.appointment_date < Time.now + 1.hour
    
  end

  def has_future_date?
    return false if self.appointment_date.blank?
    self.appointment_date > Time.now
  end

  class << self
    def future_patient_appointments(patient_id)
      self.includes(:doctor).
        where(patient_id: patient_id).
        where("appointment_date > #{Time.now}")
    end

    def get_details(param_id)
      record = self.where(id: param_id).includes(:doctor, :patient, :notes => [:user]).first
      return nil if record.blank?

      record
    end
  end
end
