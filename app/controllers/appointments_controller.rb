class AppointmentsController < ApplicationController

  before_action: :should_be_patient?, only: [:new, :create]

  def index
    @appointments = current_user.appointments
    @appointments = fetch_my_appointments
  end

  def new
    
  end

  def create
    
  end

  private

  def fetch_my_appointments
    if current_user.doctor?
      current_user.future_patient_appointments
    else
    end
  end

  
end
