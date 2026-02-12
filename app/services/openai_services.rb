class OpenaiService
    def initialize
      @client = OpenAI::Client.new(
        access_token: Rails.application.credentials.dig(:openai, :api_key)
      )
    end
  
    def chat(message)
      response = @client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [
            { role: "system", content: "You are a helpful assistant inside an ecommerce website." },
            { role: "user", content: message }
          ],
          temperature: 0.7
        }
      )
  
      response.dig("choices", 0, "message", "content")
    end
  end
  