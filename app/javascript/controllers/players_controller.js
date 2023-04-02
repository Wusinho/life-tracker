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

}
