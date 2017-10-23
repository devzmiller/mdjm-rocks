class PartsController < ApplicationController
  def index
    if session[:user_id] == nil
      redirect_to new_session_path

    elsif is_manager?
      if params[:name] || params[:warehouse_id]
        @warehouse = Warehouse.find_by(name: params[:name]) || Warehouse.find(params[:warehouse_id])

        if @warehouse == nil
          @errors = ["Warehouse doesn't exist"]
          @parts = Part.all
        else
          @parts = @warehouse.parts.uniq
          @parts = @parts.sort { |a, b| a.name.downcase <=> b.name.downcase }
        end

      else
        @parts = Part.all.sort { |a, b| a.name.downcase <=> b.name.downcase }
      end

    else
      @warehouse = User.find(session[:user_id]).warehouse
      @parts = @warehouse.parts.uniq
      @parts = @parts.sort { |a, b| a.name.downcase <=> b.name.downcase }
    end
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    @part.assign_attributes(part_params)

    if @part.save
      redirect_to parts_path
    else
      @errors = @part.errors.full_messages
      render :edit
    end
  end

  def destroy
    @warehouse = Warehouse.find(params[:warehouse_id])
    @part = Part.find(params[:id])
    WarehousesPart.where("warehouse_id = ? AND part_id = ?", params[:warehouse_id], params[:id]).limit(params[:count]).destroy_all
    redirect_to warehouse_parts_path(@warehouse)
  end

  def use
    @warehouse = Warehouse.find(params[:warehouse_id])
    @part = Part.find(params[:id])
    render :use
  end

  private

  def part_params
    params.require(:part).permit(:part_number, :max_quantity)
  end
end
