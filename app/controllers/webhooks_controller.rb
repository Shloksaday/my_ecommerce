class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"]

    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload,
        sig_header,
        endpoint_secret
      )
    rescue JSON::ParserError
      render json: { error: "Invalid payload" }, status: 400
      return
    rescue Stripe::SignatureVerificationError
      render json: { error: "Invalid signature" }, status: 400
      return
    end

    handle_event(event)

    render json: { status: "success" }
  end

  private

  def handle_event(event)
    case event.type
    when "checkout.session.completed"
      session = event.data.object

      order_id = session.metadata.order_id
      order = Order.find_by(id: order_id)

      if order
        order.update!(
          payment_status: "paid"
        )
      end
    end
  end
end
