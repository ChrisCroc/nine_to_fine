import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="typewriter"
export default class extends Controller {
  static values = { text: String, interval: { type: Number, default: 45 } }

  connect() {
    const full = this.textValue
    const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches

    if (reduced || !full) {
      this.element.textContent = full
      return
    }

    const words = full.split(" ")
    let i = 0
    this.element.textContent = ""

    this.timer = setInterval(() => {
      this.element.textContent += (i === 0 ? "" : " ") + words[i]
      i += 1
      if (i >= words.length) this.stop()
    }, this.intervalValue)
  }

  disconnect() {
    this.stop()
  }

  stop() {
    if (this.timer) { clearInterval(this.timer); this.timer = null }
  }
}
