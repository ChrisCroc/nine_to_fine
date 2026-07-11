import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "trigger"]

  connect() {
    this.closeOnEscape = this.closeOnEscape.bind(this)
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeOnEscape)
  }

  open() {
    this.overlayTarget.classList.remove("hidden")
    this.triggerTarget.setAttribute("aria-expanded", "true")
    document.addEventListener("keydown", this.closeOnEscape)
  }

  close() {
    this.overlayTarget.classList.add("hidden")
    this.triggerTarget.setAttribute("aria-expanded", "false")
    document.removeEventListener("keydown", this.closeOnEscape)
  }

  backdrop(event) {
    if (event.target === event.currentTarget) this.close()
  }

  closeOnEscape(event) {
    if (event.key === "Escape") this.close()
  }
}
