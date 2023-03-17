import consumer from "channels/consumer"

let create_players = (user_id, container) => consumer.subscriptions.create(
    {
      channel: "PlayersChannel",
      user_id: user_id
    }
    , {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
      let div = document.createElement('div')
      console.log(data)
      div.innerHTML = data.element
      console.log(container)
      console.log(div)
      container.prepend(div)
    // Called when there's incoming data on the websocket for this channel
  }
});

export default create_players;