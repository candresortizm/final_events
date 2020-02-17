class SaleEventsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  #Method to get all sale events
  def index
    begin
      ActiveRecord::Base.transaction do
        @sale_events = SaleEvent.all
      end
    rescue
      raise
    end
  end

  #Method to open a form for a new sale_event
  def new
    begin
      ActiveRecord::Base.transaction do
        if !current_user.nil? and current_user.type.eql?("Admin")
          @sale_event = SaleEvent.new
        else
          flash[:warning] = "No está autorizado"
          redirect_to root_path
        end
      end
    rescue
      raise
    end
  end

  #Method to save a new sale_event
  def create
    begin
      ActiveRecord::Base.transaction do
        if !current_user.nil? and current_user.type.eql?("Admin")
          @sale_event = SaleEvent.new(sale_event_params)
          @sale_event.admin_id = current_user.id
          @sale_event.save!
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

  #Method to open a form for edit a sale_event and their location_types
  def edit
    begin
      ActiveRecord::Base.transaction do
        if !current_user.nil? and current_user.type.eql?("Admin")
          @sale_event = SaleEvent.includes(:location_types).find(params[:event_id])
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

  #Method to show a event instance
  def show
    begin
      ActiveRecord::Base.transaction do
        if !current_user.nil? and current_user.type.eql?("Admin")
          flash[:warning] = "Por favor cierre sesión para ir a la vista de instancia."
          redirect_to root_path
        else
          @sale_event = SaleEvent.includes(:location_types).find(params[:event_id])
          @reservation = Reservation.new(client_id: current_user.id) if !current_user.nil?
        end
      end
    rescue Exception => exc
      flash[:danger] = exc.message
      redirect_to root_path
    end
  end

  #Method to update the parameters and location_types of a sale event
  def update
    begin
      ActiveRecord::Base.transaction do
        if !current_user.nil? and current_user.type.eql?("Admin")
          sale_event = SaleEvent.find(sale_event_params[:id])
          sale_event.update(sale_event_params)
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

  private

  #Strong parameters to prevent no desired params
  def sale_event_params
    params.require(:sale_event).permit(
      :id,
      :title,
      :event_date,
      :place,
      :description,
      :image,
      location_types_attributes: [
        :id,
        :name,
        :price,
        :quantity,
        :_destroy
      ]
    )
  end

end
