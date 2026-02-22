class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      redirect_to chats_path
    else
      redirect_to chats_path, alert: "Message failed to send"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end