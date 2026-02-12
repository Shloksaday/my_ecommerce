class MessagesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      message = current_user.messages.create!(message_params)
  
      ActionCable.server.broadcast(
        "chat_room",
        {
          user: message.user.email,
          content: message.content,
          time: message.created_at.strftime("%H:%M")
        }
      )
    end
  
    private
  
    def message_params
      params.require(:message).permit(:content)
    end
  end
  