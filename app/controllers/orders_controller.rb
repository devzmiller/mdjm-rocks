class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order_part = OrdersPart.new
  end

  def create
    puts "****************************************"
    @part = Part.find_or_initialize_by(part_number: params[:part_num])
    if @part.name
      if @part.name == params[:part]
        @order = Order.new(orderer_id: session[:user_id])
        @order.parts << @part
        @order.save!
        redirect_to order_path(@order)
      else
        @errors = ["Part name is invalid"]
        render :new
      end
    else
      @part.name = params[:part]
      @part.max_quantity = 100
      @order = Order.new(orderer_id: session[:user_id], submitted: false)
      @order.parts << @part
      @order.save!
      redirect_to order_path(@order)
    end
  end
end
