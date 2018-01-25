class AppointmentsController < ApplicationController

  before_action :should_be_patient?, only: [:new, :create]

  def index
    @appointments = current_user.future_appointments
  end

  def new
    @appointment = current_user.doctor_appointments.new(appointment_date: Time.now + rand(1...7).day)
    @doctors = User.where(role: 1)
  end

  def create
    @appointment = current_user.doctor_appointments.new(appointment_params)
    
    if @appointment.save
      current_user.add_appointment_note(@appointment, appointment_params[:note])
      redirect_to '/'
    else
      @doctors = User.where(role: 1)
      render :new
    end
  end

  def show
    @appointment = Appointment.get_details(params[:id])
    
  end
  

  private

  def fetch_my_appointments
    if current_user.doctor?
      current_user.future_patient_appointments
    else
    end
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :appointment_date, :note)
  end
end
