import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    window.onbeforeunload = () => {
      document.addEventListener('keydown', function (e){
        if (e.key.toString() !== 'F5') {return}

        const csrtToken = document.querySelector('meta[name="csrf-token"]').content
        fetch('/windows_close', {
          method: 'Get',
          mode: 'cors',
          cache: 'no-cache',
          credentials: 'same-origin',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrtToken
          },
        }).then(r => r.text())
            .then(html =>{})
      })
    };
  }
}
