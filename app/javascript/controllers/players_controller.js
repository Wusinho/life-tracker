import { Controller } from "@hotwired/stimulus"
import create_players from "../channels/players_channel";

// Connects to data-controller="players"
export default class extends Controller {
  connect() {
  }

  damage_to_enemies(e) {
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    console.log(player_id)
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
