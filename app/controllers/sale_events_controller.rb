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
          binding.pry
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
  end

  def index
  end

  def show
  end

  def update
  end

  private

  def sale_event_params
    params.require(:sale_event).permit(
      :id,
      :title,
      :event_date,
      :place,
      :image
    )
  end

end
