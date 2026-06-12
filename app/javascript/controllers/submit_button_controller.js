// app/javascript/controllers/submit_button_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-button"
export default class extends Controller {
  static targets = ["button"]

  start() {
    this.buttonTarget.dataset.loading = "true"
  }

  end() {
    this.buttonTarget.dataset.loading = "false"
  }
}
