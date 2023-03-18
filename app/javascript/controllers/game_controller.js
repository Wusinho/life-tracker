import { Controller } from "@hotwired/stimulus"
import game from "../channels/game_channel";

// Connects to data-controller="game"
export default class extends Controller {
  connect() {
    let container = this.element
    const user_id = container.dataset.userId
    game(user_id, container)
  }
}
