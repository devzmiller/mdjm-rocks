class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
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
  end

  private

  def warehouse_params
    params.require(:user).permit(:warehouse)["warehouse"]
  end

  def user_params
    params.require(:user).permit(:name, :employee_num, :password)
  end
end
