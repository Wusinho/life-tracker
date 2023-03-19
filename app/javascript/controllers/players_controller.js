import { Controller } from "@hotwired/stimulus"
import create_players from "../channels/players_channel";

// Connects to data-controller="players"
export default class extends Controller {
  connect() {
  }

  damage_to_enemies(e) {
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    const csrtToken = document.querySelector('meta[name="csrf-token"]').content
    fetch("/players/damage_to_enemies", {
      method: 'Post',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrtToken
      },
      body: JSON.stringify({ id: player_id })

    }).then(r => r.text())
        .then(html =>{

          let msg = JSON.parse(html)
          console.log(msg)
        //   if (msg.message) {
        //     modal.classList.remove("invisible")
        //     modal.innerHTML = msg.message
        //   } else {
        //     window.location = msg.url
        //   }
        } )
  }

  heal(e){
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    console.log(player_id)
  }

  damage_to(e){
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    console.log(player_id)
  }

}
