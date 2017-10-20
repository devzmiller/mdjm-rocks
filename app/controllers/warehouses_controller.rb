class WarehousesController < ApplicationController
  def new
    if is_manager?
      @warehouse = Warehouse.new
    else
      render "shared/404"
    end
  end

  def create
    if is_manager?
      @warehouse = Warehouse.new(warehouse_params)
      if @warehouse.save
        @parts = @warehouse.parts.uniq
        render "parts/index"
      else
        @errors = @warehouse.errors.full_messages
        render :new
      end
    else
      render "shared/404"
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name)
  end

  def is_manager?
    return true if User.find(session[:user_id]).role == "manager"
    false
  end
end
