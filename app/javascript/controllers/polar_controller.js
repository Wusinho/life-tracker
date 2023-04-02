import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="polar"
export default class extends Controller {
  connect() {
    const ctx = this.element
    new Chart(ctx, {
      type: 'polarArea',
      data: {
        labels: JSON.parse(ctx.dataset.labels),
        datasets: [{
          label: 'All your kills',
          data: JSON.parse(ctx.dataset.data),
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'All your kills'
          }
        }
      },
    });
  }
}
