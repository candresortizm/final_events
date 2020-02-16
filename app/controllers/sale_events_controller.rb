class SaleEventsController < ApplicationController

  def index
    begin
      ActiveRecord::Base.transaction do
        @sale_events = SaleEvent.all
      end
    rescue
      raise
    end
  end

  def new
    begin
      ActiveRecord::Base.transaction do
        @sale_event = SaleEvent.new
      end
    rescue
      raise
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        if current_user.type.eql?("Admin")
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

  def edit
    begin
      ActiveRecord::Base.transaction do
        @sale_event = SaleEvent.find(params[:event_id])
      end
    rescue Exception => exc
      flash[:danger] = exc.message
      redirect_to root_path
    end
  end

  def show
    begin
      ActiveRecord::Base.transaction do
        @sale_event = SaleEvent.find(params[:event_id])
      end
    rescue Exception => exc
      flash[:danger] = exc.message
      redirect_to root_path
    end
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        if current_user.type.eql?("Admin")
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

  def sale_event_params
    params.require(:sale_event).permit(
      :id,
      :title,
      :event_date,
      :place,
      :description,
      :image,
      location_types_attributes: [
        :name,
        :price,
        :quantity
      ]
    )
  end

end
