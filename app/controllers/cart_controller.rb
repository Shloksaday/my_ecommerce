class CartController < ApplicationController
  def show
    @cart_items = Product.find(cart.keys)
  end

  def add
    cart[params[:product_id]] = (cart[params[:product_id]] || 0) + 1
    redirect_back fallback_location: root_path, notice: "Product added to cart"
  end

  def remove
    cart.delete(params[:product_id])
    redirect_to cart_path, notice: "Product removed from cart"
  end

  private

  def cart
    session[:cart] ||= {}
  end
end
