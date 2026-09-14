import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="long-wait"
export default class extends Controller {
  static targets = ['fallback']
  static values = { delay: { type: Number, default: 20000 } }

  connect() {
    this.timeout = setTimeout(() => this.reveal(), this.delayValue)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  reveal() {
    this.fallbackTarget.classList.remove("hidden")
  }
}
