import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "icon"]
  static values = { liked: Boolean }

  flip() {
    this.previousLiked = this.likedValue
    this.likedValue = !this.likedValue
    this.iconTarget.textContent = this.likedValue ? "♥" : "♡"
    this.buttonTarget.disabled = true
  }

  confirm(event) {
    this.buttonTarget.disabled = false
    if (!event.Detail.success) {
      this.likedValue = this.previousLiked
      this.iconTarget.textContent = this.likedValue ? "♥" : "♡"
    }
  }
}
