import { Controller } from "@hotwired/stimulus"
import NestedForm from 'stimulus-rails-nested-form'

// Connects to data-controller="add-players"
export default class extends Controller {
  connect() {
    console.log(NestedForm)
  }

  click(e){
  }
}
