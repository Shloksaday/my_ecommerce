class ChatController < ApplicationController
  def index
  end

  def create
    user_message = params[:message]

    conn = Faraday.new(url: "https://openrouter.ai") do |f|
      f.request :json
      f.response :json
    end

    def create
      user_message = params[:message]
    
      conn = Faraday.new(url: "https://openrouter.ai")
    
      response = conn.post("/api/v1/chat/completions") do |req|
        req.headers["Authorization"] = "Bearer #{ENV['OPENROUTER_API_KEY']}"
        req.headers["Content-Type"] = "application/json"
        req.headers["HTTP-Referer"] = "http://localhost:3000"
        req.headers["X-Title"] = "MyEcommerceApp"
    
        req.body = {
          model: "mistralai/mistral-7b-instruct",
          messages: [
            { role: "user", content: user_message }
          ]
        }.to_json
      end
    
      parsed_response = JSON.parse(response.body)
      @reply = parsed_response.dig("choices", 0, "message", "content") || "AI did not respond."
    
      render :index
    end
    
  end
end
