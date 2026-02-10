module WishlistsHelper
    def wished?(product)
      user_signed_in? &&
        current_user.wishlists.exists?(product_id: product.id)
    end
  end
  