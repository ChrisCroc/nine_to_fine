import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.activeIndex = - 1
  }

  get optionElements() {
    return Array.from(this.element.querySelectorAll('[role="option"]'))
  }

  highlight() {
    const options = this.optionElements
    options.forEach((option, index) => {
      const isActive = index === this.activeIndex
      if (isActive) {
        option.classList.add("bg-zinc-100")
      } else {
        option.classList.remove("bg-zinc-100")
      }
      option.setAttribute("aria-selected", isActive)
    })
    const active = options[this.activeIndex]
    if (active) {
      this.inputTarget.setAttribute("aria-activedescendant", active.id)
      active.scrollIntoView({ block: "nearest" })
    }
  }

  navigate(event) {
    const options = this.optionElements

    switch (event.key) {
      case "ArrowDown":
        if (options.length === 0) return
        event.preventDefault()
        this.activeIndex = (this.activeIndex + 1) % options.length
        this.highlight()
        break
      case "ArrowUp":
        if (options.length === 0) return
        event.preventDefault()
        this.activeIndex = (this.activeIndex -1 + options.length) % options.length
        this.highlight()
        break
      case "Enter":
        event.preventDefault()
        if (this.activeIndex >= 0) options[this.activeIndex].click()
        break

    }
  }
}
