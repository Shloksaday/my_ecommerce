class OrdersController < ApplicationController
  before_action :authenticate_user!

  # -------------------------------
  # STRIPE BUY NOW FLOW
  # -------------------------------
  def buy_now
    product = Product.find(params[:product_id])
  
    order = current_user.orders.create!(
      product: product,
      total_price: product.price,          # ✅ REQUIRED
      status: "pending",
      payment_status: "pending"
    )
  
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: product.name
          },
          unit_amount: (product.price * 100).to_i
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_orders_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_orders_url,
      metadata: {
        order_id: order.id
      }
    )
  
    order.update!(stripe_session_id: stripe_session.id)
  
    redirect_to stripe_session.url, allow_other_host: true
  end
  

  def success
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    order = Order.find(stripe_session.metadata.order_id)
  
    return if order.payment_status == "paid"
  
    order.update!(payment_status: "paid")
  
    UserMailer.order_confirmation(order).deliver_now
  end
  

  def cancel
    # optional: show payment failed page
  end

  # -------------------------------
  # CART CHECKOUT FLOW
  # -------------------------------
  def new
    @cart = session[:cart]
    redirect_to cart_path if @cart.blank?
  end

  def create
    total = Product.where(id: session[:cart].keys).sum do |product|
      product.price * session[:cart][product.id.to_s]
    end

    @order = current_user.orders.create!(
      total: total,
      status: "placed",
      payment_status: "paid"
    )

    session[:cart] = {}

    # # 📩 SEND MAIL HERE
    # UserMailer.order_confirmation(@order).deliver_now

    redirect_to @order, notice: "Order placed successfully 🎉"
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
