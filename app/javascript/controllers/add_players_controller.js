import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-players"
export default class extends Controller {
  connect() {
  }

  click(e){
    console.log(e.target)
  }
}
