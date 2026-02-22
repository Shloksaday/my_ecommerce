class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists.includes(:product)
  end

  def create
    product = Product.find(params[:product_id])
    current_user.wishlists.create!(product: product)

    ActionCable.server.broadcast(
      "notifications_#{current_user.id}",
      {
        message: "❤️ #{product.name} added to wishlist!"
      }
    )

    redirect_back fallback_location: products_path
  end

  def destroy
    wishlist = current_user.wishlists.find(params[:id])
    wishlist.destroy
    redirect_to wishlists_path, notice: "Removed from wishlist"
  end

  def move_to_cart
    wishlist = current_user.wishlists.find(params[:id])
    product = wishlist.product

    cart = current_user.cart || current_user.create_cart
    cart.cart_items.find_or_create_by(product: product)

    wishlist.destroy

    redirect_to wishlists_path, notice: "Moved to cart successfully"
  end
end
