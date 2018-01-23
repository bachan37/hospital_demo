class Appointment < ActiveRecord::Base
  enum status: [:pending, :completed, :cancelled]
  
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  has_many :notes
end
