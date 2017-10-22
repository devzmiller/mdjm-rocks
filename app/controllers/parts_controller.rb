class PartsController < ApplicationController
  def index
    if session[:user_id] == nil
      redirect_to new_session_path
    elsif is_manager?
      if params[:name]
        @warehouse = Warehouse.find_by(name: params[:name])
        if @warehouse == nil
          @errors = ["Warehouse doesn't exist"]
          @parts = Part.all
        else
          @parts = @warehouse.parts.uniq
        end
      else
        @parts = Part.all
      end
    else
      @warehouse = User.find(session[:user_id]).warehouse
      @parts = @warehouse.parts.uniq
    end
  end
  
  def edit
    @warehouse = Warehouse.find(params[:warehouse_id])
    @part = Part.find(params[:id])
  end
end
