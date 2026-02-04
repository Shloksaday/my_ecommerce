class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  
  def index
  @orders = current_user.orders
  end
  
  
  def show
  @order = current_user.orders.find(params[:id])
  end
  
  
  def create
  @order = current_user.orders.create(status: 'pending')
  redirect_to @order
  end
  end