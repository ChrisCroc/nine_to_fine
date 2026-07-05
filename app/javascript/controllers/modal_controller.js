import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.closeOnEscape = this.closeOnEscape.bind(this)
    document.addEventListener("keydown", this.closeOnEscape)
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeOnEscape)
  }
  close() {
    this.element.remove()
  }

  backdrop(event) {
    if (event.target === this.element) this.close()
  }

  closeOnEscape(event) {
    if (event.key === "Escape") this.close()
  }
}
