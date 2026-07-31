import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "input", "name", "color", "category",
    "formality", "season", "pattern", "flag", "spinner", "error"
  ]

  analyze() {
    const file = this.inputTarget.files[0]
    if (!file || this.pending) return
    this.pending = true
    this.start()

    const body = new FormData()
    body.append("photo", file)
    fetch("/garments/analyses", {
      method: "POST",
      headers: { "X-CSRF-Token": this.csrfToken() },
      body
    })
      .then((response) => {
        if (!response.ok) throw new Error("analysis_failed")
        return response.json()
      })
      .then((data) => this.fill(data))
      .catch(() => this.errorTarget.classList.remove("hidden"))
      .finally(() => { this.pending = false; this.stop() })
  }

  fill(data) {
    this.setText(this.nameTarget, data.name)
    this.setColor(data.color)
    this.setSelect(this.categoryTarget, data.category_id)
    this.setSelect(this.formalityTarget, data.formality)
    this.setSelect(this.seasonTarget, data.season)
    this.setSelect(this.patternTarget, data.pattern)
    this.flagTarget.value = "1"
  }

  setText(element, value) {
    if (value) element.value = value
  }

  setSelect(element, value) {
    if (value === null || value === undefined) return
    element.value = value
  }

  setColor(value) {
    if (!value) return
    const ts = this.colorTarget.tomselect
    if (ts) ts.setValue(value)
    else this.colorTarget.value = value
  }

  start() {
    this.errorTarget.classList.add("hidden")
    this.spinnerTarget.classList.remove("hidden")
  }

  stop() {
    this.spinnerTarget.classList.add("hidden")
  }

  csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }
}
