class UsersController < ApplicationController

  def new
    if is_manager?
      @user = User.new
    else
      render "shared/404"
    end
  end

  def create
    if is_manager?
      @user = User.new(user_params)
      @user.role = params.permit(:role)
      @warehouse = Warehouse.find_by(name: warehouse_params)
      @user.warehouse = @warehouse
      if @user.save
        redirect_to parts_path
      else
        @errors = @user.errors.full_messages
        render :new
      end
    else
      render "shared/404"
    end
  end

  private

  def warehouse_params
    params.require(:user).permit(:warehouse)["warehouse"]
  end

  def user_params
    params.require(:user).permit(:name, :employee_num, :password)
  end
end
