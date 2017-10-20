class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @part = Part.find_by(part_number: params[:part_num]) || Part.find_by(name: params[:part])
    @errors = []

    if @part
      if @part.name != params[:part] || @part.part_number != params[:part_num].to_i
        @errors << "Use correct part name/number. #{@part.name}, no. #{@part.part_number}."
      end
    else
      @part = Part.create(name: params[:part], max_quantity: 100, part_number: params[:part_num])
      @errors += @part.errors.full_messages
    end

    @order = Order.create(orderer_id: session[:user_id], submitted: false)
    order_part = OrdersPart.create(quantity_ordered: params[:quantity], part: @part, order: @order)
    @errors += @order.errors.full_messages
    @errors += order_part.errors.full_messages

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

    @part = Part.find_by(part_number: params[:part_num]) || Part.find_by(name: params[:part])
    @errors = []

    if @part
      if @part.name != params[:part] || @part.part_number != params[:part_num].to_i
        @errors << "Use correct part name/number. #{@part.name} has the number #{@part.part_number}, not #{params[:part_num]}"
      end
    else
      @part = Part.create(name: params[:part], max_quantity: 100, part_number: params[:part_num])
      @errors += @part.errors.full_messages
    end

    order_part = OrdersPart.new(quantity_ordered: params[:quantity], part: @part, order: @order)
    @errors += order_part.errors.full_messages

    if @errors == [] && order_part.save
      redirect_to order_path(@order)
    else
      render :show
    end
  end
end
