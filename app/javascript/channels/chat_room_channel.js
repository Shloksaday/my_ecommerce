import consumer from "./consumer"

consumer.subscriptions.create("ChatRoomChannel", {
  received(data) {
    const messages = document.getElementById("messages")

    messages.insertAdjacentHTML(
      "beforeend",
      `
      <div class="mb-2">
        <strong>${data.user}</strong>:
        <span>${data.content}</span>
        <span class="text-xs text-gray-500 ml-2">${data.time}</span>
      </div>
      `
    )

    messages.scrollTop = messages.scrollHeight
  }
})
