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
      redirect_to edit_part_path(@part)
    else
      @errors = @part.errors.full_messages
      render :edit
    end
  end

  private

  def part_params
    params.require(:part).permit(:part_number, :max_quantity)
  end
end
