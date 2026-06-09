// app/javascript/controllers/color_select_controller.js
import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="color-select"
export default class extends Controller {
  connect() {
    this.select = new TomSelect(this.element, {
      placeholder: "Choose a color",
      dropdownParent: "body",
      render: {
        option: (data, escape) => this.renderRow(data, escape),
        item: (data, escape) => this.renderRow(data, escape)
      }
    })
  }

  disconnect() {
    this.select?.destroy()
  }

  renderRow(data, escape) {
    const hex = escape(data.hex || "#cccccc")
    const text = escape(data.text)
    return `<div class="flex items-center gap-2">
      <span class="inline-block w-3 h-3 rounded-full ring-1 ring-zinc-300" style="background:${hex}"></span>
      ${text}
    </div>`
  }
}
