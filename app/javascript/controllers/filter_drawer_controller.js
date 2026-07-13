import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "panel", "trigger"]

  connect() {
    this.closeOnEscape = this.closeOnEscape.bind(this)
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeOnEscape)
  }

  open() {
    this.overlayTarget.classList.remove("hidden")
    this.panelTarget.offsetHeight // force the reflow so the slide gets animated
    this.panelTarget.classList.remove("translate-x-full")
    this.triggerTarget.setAttribute("aria-expanded", "true")
    document.addEventListener("keydown", this.closeOnEscape)
    this.panelTarget.focus()
  }

  close() {
    this.panelTarget.classList.add("translate-x-full")
    this.triggerTarget.setAttribute("aria-expanded", "false")
    document.removeEventListener("keydown", this.closeOnEscape)
    this.panelTarget.addEventListener(
      "transitionend",
      () => this.overlayTarget.classList.add("hidden"),
      { once: true }
    )
  }

  backdrop(event) {
    if (event.target === event.currentTarget) this.close()
  }

  closeOnEscape(event) {
    if (event.key === "Escape") this.close()
  }
}
