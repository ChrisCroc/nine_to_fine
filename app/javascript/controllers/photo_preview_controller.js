import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "image", "placeholder", "clear"]

  connect() {
    this.initialSrc = this.imageTarget.getAttribute("src")
    this.currentUrl = null
  }

  update() {
    const file = this.inputTarget.files[0]
    this.revoke()
    this.clearTarget.classList.add("invisible")
    if (file) {
      this.currentUrl = URL.createObjectURL(file)
      this.showImage(this.currentUrl)
      this.clearTarget.classList.remove("invisible")
    } else if (this.initialSrc) {
      this.showImage(this.initialSrc)
    } else {
      this.showPlaceholder()
    }
  }

  showImage(src) {
    this.imageTarget.src = src
    this.imageTarget.classList.remove("hidden")
    this.placeholderTarget.classList.add("hidden")
  }

  showPlaceholder() {
    this.imageTarget.removeAttribute("src")
    this.imageTarget.classList.add("hidden")
    this.placeholderTarget.classList.remove("hidden")
  }

  revoke() {
    if (this.currentUrl) {
      URL.revokeObjectURL(this.currentUrl)
      this.currentUrl = null
    }
  }

  disconnect() {
    this.revoke()
  }

  clear() {
    this.inputTarget.value = ""
    this.update()
  }
}
