class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def add
    session[:cart] ||= {}
    session[:cart][params[:product_id]] = (session[:cart][params[:product_id]] || 0) + 1
    redirect_to cart_path, notice: "Added to cart"
  end

  def remove
    session[:cart]&.delete(params[:product_id])
    redirect_to cart_path, notice: "Removed from cart"
  end
end
