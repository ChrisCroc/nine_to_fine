import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="garment-select"
export default class extends Controller {
  static targets = ["select", "board"]

  connect() {
    this.select = new TomSelect(this.selectTarget, {
      placeholder: "Search and add pieces of clothes",
      plugins: ["remove_button"],
      dropdownParent: "body",
      render: {
        option: (data, escape) => this.renderRow(data, escape),
        item: (data,escape) => this.renderRow(data, escape)
      }
    })
  }

  disconnect() {
    this.select?.destroy()
  }

  renderRow(data, escape) {
    const name = escape(data.text)
    const thumb = data.thumb
    const visual = thumb
      ? `<img src="${escape(thumb)}" class="h-6 w-6 rounded object-cover ring-1 ring-zinc-200">`
      : `<span class="inline-flex h-6 w-6 items-center justify-center rounded bg-zinc-200 text-xs font-bold text-zinc-500">${escape(name.charAt(0).toUpperCase())}</span>`
    return `<div class="flex items-center gap-2">${visual}${name}</div>`
  }
}
