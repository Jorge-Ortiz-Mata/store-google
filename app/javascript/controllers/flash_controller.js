import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  removeNotice() {
    document.getElementById('notice').remove();
  }

  removeAlert() {
    document.getElementById('alert').remove();
  }
}
