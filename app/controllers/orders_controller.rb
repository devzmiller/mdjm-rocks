class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order_part = OrdersPart.new
  end
end
