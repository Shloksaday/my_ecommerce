class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = session[:cart] || {}
    @cart_items = Product.where(id: @cart.keys)

    @total_price = calculate_total
  end

  def add
    session[:cart] ||= {}
    id = params[:product_id].to_s
    session[:cart][id] ||= 0
    session[:cart][id] += 1

    redirect_back fallback_location: products_path
  end

  def increase
    id = params[:product_id].to_s
    session[:cart][id] += 1
    respond_to_turbo
  end

  def decrease
    id = params[:product_id].to_s
    session[:cart][id] -= 1
    session[:cart].delete(id) if session[:cart][id] <= 0
    respond_to_turbo
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)
    redirect_to cart_path
  end

  private

  def calculate_total
    Product.where(id: session[:cart].keys).sum do |p|
      p.price * session[:cart][p.id.to_s]
    end
  end

  def respond_to_turbo
    @cart = session[:cart]
    @cart_items = Product.where(id: @cart.keys)
    @total_price = calculate_total
    render turbo_stream: turbo_stream.replace("cart", partial: "carts/cart")
  end
end
