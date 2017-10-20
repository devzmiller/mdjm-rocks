class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    # Look for a part by its part number
    part = Part.find_or_initialize_by(part_number: params[:part_num])
    @errors = []
    # If part.name is initialized, then the part must have already existed
    if part.name
      # Check if user got part name correct
      if part.name == params[:part]
        # If so, add the part to that order for that quantity
        @order = Order.create(orderer_id: session[:user_id], submitted: false)
        order_part = OrdersPart.create(quantity_ordered: params[:quantity], part: part, order: @order)
        @errors += @order.errors.full_messages
        @errors += order_part.errors.full_messages
      else
        @errors << "Part name is invalid"
      end
    else
      # If part.name isn't initialized, we made a new part, initialize the other attributes
      part.update_attributes(name: params[:part], max_quantity: 100)
      # Then add the part to that order for that quantity
      @order = Order.create(orderer_id: session[:user_id], submitted: false)
      order_part = OrdersPart.create!(quantity_ordered: params[:quantity], part: part, order: @order)
      @errors += @order.errors.full_messages
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
    @errors = []
    if @part.name
      if @part.name == params[:part]
        if @order.parts.include?(@part)
          @order.parts
        else
          order_part = OrdersPart.create(quantity_ordered: params[:quantity], part: @part, order: @order)
          @errors += order_part.errors.full_messages
        end
      else
        @errors << "Part name is invalid"
      end
    else
      @part.update_attributes(name: params[:part], max_quantity: 100)
      order_part = OrdersPart.create!(quantity_ordered: params[:quantity], part: @part, order: @order)
      @errors += @part.errors.full_messages
      @errors += order_part.errors.full_messages
    end

    if @errors == []
      redirect_to order_path(@order)
    else
      render :show
    end
  end
end
