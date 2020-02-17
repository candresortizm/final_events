class ReservationsController < ApplicationController
  before_action :authenticate_user!

  #Method to add a new reservation
  def create
    begin
      ActiveRecord::Base.transaction do
        if !current_user.type.eql?("Admin")
          @reservation = Reservation.new(reservation_params)
          @reservation.client_id = current_user.id
          @reservation.save!
          flash[:success] = "Has hecho la compra satisfactoriamente."
          redirect_to root_path
        else
          flash[:warning] = "No está autorizado"
          redirect_to root_path
        end
      end
    rescue Exception => exc
      flash[:danger] = exc.message
      redirect_to root_path
    end
  end

  #Method to get reservations for user, according role
  def index
    begin
      ActiveRecord::Base.transaction do
        if !current_user.type.eql?("Admin")
          @all_reservations = current_user.reservations
        else
          @all_reservations = Reservation.includes(:client, location_type: :sale_event).joins(
                            location_type: :sale_event).where(sale_events:{admin_id: current_user.id})
        end
      end
    rescue Exception => exc
      flash[:danger] = exc.message
      redirect_to root_path
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :location_type_id,
      :quantity
    )
  end
end
