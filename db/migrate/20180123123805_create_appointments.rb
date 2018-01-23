class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :appointment_date, null: false
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
