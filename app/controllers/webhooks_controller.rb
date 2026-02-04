class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"]

    begin
      event = Stripe::Webhook.construct_event(
        payload,
        sig_header,
        endpoint_secret
      )
    rescue JSON::ParserError
      return render json: { error: "Invalid payload" }, status: 400
    rescue Stripe::SignatureVerificationError
      return render json: { error: "Invalid signature" }, status: 400
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object

      order = Order.find_by(stripe_session_id: session.id)

      if order
        order.update(status: "paid")
      end
    end

    render json: { status: "success" }
  end
end
