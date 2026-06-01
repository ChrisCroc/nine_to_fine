import { Controller } from "@hotwired/stimulus"
  import TomSelect from "tom-select"

  // Connects to data-controller="select"
  export default class extends Controller {
    connect() {
      this.select = new TomSelect(this.element, {
        placeholder: "Search and add pieces of clothes",
        plugins: ["remove_button"],
        dropdownParent: "body"
      })
    }

    disconnect() {
      this.select.destroy()
    }
  }
