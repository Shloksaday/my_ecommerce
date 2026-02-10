class CartItemsController < ApplicationController
    def create
      session[:cart] ||= []
      session[:cart] << params[:product_id].to_i
  
      redirect_to cart_path, notice: "Item added to cart"
    end
  
    def destroy
      session[:cart].delete(params[:id].to_i)
      redirect_to cart_path, notice: "Item removed"
    end
  end
  