import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game"
export default class extends Controller {
  connect() {
    const ctx = this.element
    new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: JSON.parse(ctx.dataset.labels),
        datasets: [{
          label: 'Win rate',
          data: JSON.parse(ctx.dataset.data),
          borderWidth: 1
        }]
      },
    });
  }
}
