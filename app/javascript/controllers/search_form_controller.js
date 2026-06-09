// app/javascript/controllers/search_form_controller.js
import { Controller } from "@hotwired/stimulus"

//Connects to data-controller="search-form"
export default class extends Controller {
  static targets = [ "input" ]
  static values = { delay: { type: Number, default: 300 }}

  connect() {
    this.timeout = null
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  scheduleSubmit() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, this.delayValue)
  }
}
