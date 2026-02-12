class ChatController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    service = OpenaiService.new
    @response = service.chat(params[:message])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path }
    end
  end
end
