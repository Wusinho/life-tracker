import consumer from "channels/consumer"

const game = (user_id, container) => consumer.subscriptions.create(
    {
      channel: "GameChannel",
      user_id: user_id
  },
    {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
      let div = document.createElement('div')
      div.innerHTML = data.element
      container.prepend(div)
    // Called when there's incoming data on the websocket for this channel
  }
});

export default game;