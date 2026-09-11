import { Controller } from "@hotwired/stimulus"
// Fills the composer's hidden latitude/longitude fields so the job can look up
// the real weather. Doing nothing is a valid outcome: no position means no
// weather line in the prompt, and the suggestion works exactly as before.

export default class extends Controller {
  static targets = ["latitude", "longitude"]

  connect() {
    this.asked = false
  }

  // Browsers remember a refusal for good, so we ask on the first keystroke -
  // when the user is visibly composing - rather than on page load, where the
  // prompt would arrive with no context and collect denials.

  request() {
    if (this.asked) return
    this.asked = true

    navigator.geolocation?.getCurrentPosition(
      (position) => this.fill(position.coords),
      () => {}, // a refusal or a failure is a normal outcome: no position, no weather
      { timeout: 5000, maximumAge: 600000 }
    )
  }

  // /!\ setAttribute, never .value: reset_form_controller calls form.reset() on
  // every successful submit, and reset() restores each field to its value
  // ATTRIBUTE. Writing .value alone would survive exactly one suggestion.
  fill(coords) {
    this.latitudeTarget.setAttribute("value", coords.latitude)
    this.longitudeTarget.setAttribute("value", coords.longitude)
  }
}
