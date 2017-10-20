class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    part = Part.find_or_initialize_by(part_number: params[:part_num])
    @errors = []
    if part.name
      if part.name == params[:part]
        @order = Order.create(orderer_id: session[:user_id], submitted: false)
        order_part = OrdersPart.create(quantity_ordered: params[:quantity], part: part, order: @order)
        @errors << @order.errors.full_messages
        @errors << order_part.errors.full_messages
      else
        @errors << "Part name is invalid"
      end
    else
      part.update_attributes(name: params[:part], max_quantity: 100)
      @order = Order.create(orderer_id: session[:user_id], submitted: false)
      order_part = OrdersPart.create!(quantity_ordered: params[:quantity], part: part, order: @order)
      @errors << @order.errors.full_messages
      @errors << order_part.errors.full_messages
    end
    if @errors == []
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if params[:submit] == 'true'
      @order.submitted = true;
      @order.save!
      redirect_to order_path(@order)
      return
    end
    @part = Part.find_or_initialize_by(part_number: params[:part_num])
    if @part.name
      if @part.name == params[:part]
        o = OrdersPart.create!(quantity_ordered: params[:quantity], part: @part, order: @order)
        puts "****************************************"
        p "PART ALREADY EXISTS!"
        p o
        redirect_to order_path(@order)
      else
        @errors = ["Part name is invalid"]
        render :show
      end
    else
      @part.name = params[:part]
      @part.max_quantity = 100
      @part.save!
      o = OrdersPart.create!(quantity_ordered: params[:quantity], part: @part, order: @order)
      puts "****************************************"
      p 'HAD TO MAKE A NEW PART'
      p o
      redirect_to order_path(@order)
    end
  end
end
