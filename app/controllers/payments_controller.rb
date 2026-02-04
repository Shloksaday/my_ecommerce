class PaymentsController < ApplicationController
    def checkout
      product = Product.find(params[:product_id])
  
      order = Order.create!(
        product: product,
        total_price: product.price,
        status: "pending"
      )
  
      session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        line_items: [{
          price_data: {
            currency: "inr",
            product_data: {
              name: product.name
            },
            unit_amount: (product.price * 100).to_i   # 👈 FIXED
          },
          quantity: 1
        }],
        mode: "payment",
        success_url: success_payments_url(order_id: order.id),
        cancel_url: cancel_payments_url(order_id: order.id)
      )
  
      order.update!(stripe_session_id: session.id)
  
      redirect_to session.url, allow_other_host: true
    end
  end
  