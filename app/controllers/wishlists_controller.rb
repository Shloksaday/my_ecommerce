class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists.includes(:product)
  end

  def create
    current_user.wishlists.find_or_create_by(product_id: params[:product_id])
    redirect_back fallback_location: products_path
  end

  def destroy
    wishlist = current_user.wishlists.find_by(product_id: params[:product_id])
    wishlist&.destroy
    redirect_back fallback_location: products_path
  end

  def move_to_cart
    wishlist = current_user.wishlists.find(params[:id])
    product = wishlist.product

    # Add to cart (adjust if your cart logic differs)
    cart = current_user.cart || current_user.create_cart
    cart.cart_items.find_or_create_by(product: product)

    wishlist.destroy

    redirect_to wishlists_path, notice: "Moved to cart successfully"
  end
end
