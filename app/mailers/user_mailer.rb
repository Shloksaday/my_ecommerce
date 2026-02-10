# class OrderMailer < ApplicationMailer
#     default from: "sadayshlok@gmail.com"
  
#     def welcome_emails(user)
#       @user = user
#       # @user  = order.user

#       mail(
#         # to: @user.email,
#         to: "sadayshlok@gmail.com"
#         subject: "🛒 Order Confirmation - Order ##{@order.id}"
#       )
#     end
#   end
  

  class UserMailer < ApplicationMailer
    def order_confirmation(product)
      @product = product
      @user = product.user
      mail(
        # to: product.user.email,
        to: @user.email,
        subject: "Order Confirmation ##{@product.id}"
      )
    end
  end
  