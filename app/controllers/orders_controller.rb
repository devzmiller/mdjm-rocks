require 'date'

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
      if @part.name != params[:part] || @part.part_number != params[:part_num]
        @errors << "Use correct part name/number. #{@part.name}, no. #{@part.part_number}."
      end
    else
      @part = Part.create(name: params[:part], max_quantity: 100, part_number: params[:part_num])
      @errors += @part.errors.full_messages
    end

    warehouse = Warehouse.find_by_name(params[:warehouse])
    if !warehouse
      @errors << "Please check warehouse spelling."
      render :new
      return
    end

    @order = Order.create(orderer_id: session[:user_id], submitted: false, warehouse: warehouse)
    order_part = OrdersPart.create(quantity_ordered: params[:quantity], part: @part, order: @order)
    @errors += @order.errors.full_messages
    @errors += order_part.errors.full_messages

    if @errors == []
      redirect_to order_path(@order)
    else
      render :new
      return
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.submitted
      # receiver to current user
      @order.receiver = User.find(session[:user_id])
      @order.save

      # update all received quantities in parts
      @order.orders_parts.each do |order_part|
        order_part.quantity_received = params["#{order_part.part_id}"]
        order_part.save
      end

      # set received date to today
      @order.received_date = DateTime.now
      @order.save

      # update inventory
      warehouse = @order.warehouse
      @order.orders_parts.each do |order_part|
        order_part.quantity_received.times do
          part = order_part.part
          WarehousesPart.create(part: part, warehouse: warehouse)
        end
      end

      # redirect to order show page
      redirect_to order_path(@order)
      return
    end

    if params[:submit] == 'true'
      @order.submitted = true;
      @order.save!
      redirect_to order_path(@order)
      return
    end

    @part = Part.find_by(part_number: params[:part_num]) || Part.find_by(name: params[:part])
    @errors = []

    if @part
      if @part.name != params[:part] || @part.part_number != params[:part_num]
        @errors << "Use correct part name/number. #{@part.name} has the number #{@part.part_number}."
      end
    else
      @part = Part.create(name: params[:part], max_quantity: 100, part_number: params[:part_num])
      @errors += @part.errors.full_messages
    end

    if @order.parts.include?(@part)
      order_part = OrdersPart.find_by(part: @part, order: @order)
      order_part.update_attributes(quantity_ordered: order_part.quantity_ordered + params[:quantity].to_i)
    else
      order_part = OrdersPart.new(quantity_ordered: params[:quantity], part: @part, order: @order)
    end
    @errors += order_part.errors.full_messages

    if @errors == [] && order_part.save
      redirect_to order_path(@order)
    else
      render :show
    end
  end
end
