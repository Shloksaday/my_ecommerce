class ChatsController < ApplicationController
  def index
    @messages = Message.includes(:user).order(created_at: :asc)
    @message = Message.new
  end
end