import { Controller } from "@hotwired/stimulus"
import create_players from "../channels/players_channel";

// Connects to data-controller="players"
export default class extends Controller {
  connect() {
    const current_user_id = document.querySelector('#current_user').className
    create_players(current_user_id, this.element)
  }
}
