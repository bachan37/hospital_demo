# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..4).each do |i|
  doctor_data = {
    email: "doctor#{i}@hospital.com",
    password: 'mindfire',
    password_confirmation: 'mindfire',
    role: 1
  }

  doctor = User.new(doctor_data)
  doctor.save
end

(1..40).each do |i|
  patient_data = {
    email: "patient#{i}@hospital.com",
    password: 'mindfire',
    password_confirmation: 'mindfire'
  }

  patient = User.new(patient_data)
  patient.save
end
