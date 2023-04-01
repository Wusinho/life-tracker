import { Controller } from "@hotwired/stimulus"
import create_players from "../channels/players_channel";

// Connects to data-controller="players"
export default class extends Controller {
  connect() {
    const ctx = this.element
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.dataset.labels),
        datasets: [{
          label: 'Kills per game',
          data: JSON.parse(ctx.dataset.data),
          borderColor: 'rgb(75, 192, 192)',
          fill: true,
          tension: 0.2
        }]
      },
    });


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
        } )
  }

  heal(e){
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    const csrtToken = document.querySelector('meta[name="csrf-token"]').content
    fetch("/players/heal", {
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
        } )
  }

  damage_to(e){
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    const csrtToken = document.querySelector('meta[name="csrf-token"]').content
    fetch("/players/damage_to", {
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
        } )
  }


  kaboom(e){
    e.preventDefault()
    const player_id = this.element.dataset.playerId
    const csrtToken = document.querySelector('meta[name="csrf-token"]').content
    fetch('/players/kaboom', {
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
        } )
  }
}
