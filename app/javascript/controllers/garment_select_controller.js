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
    this.select.on("item_add", () => this.renderBoard())
    this.select.on("item_remove", () => this.renderBoard())
    this.renderBoard()
    // The composer form is reset on every successful submit (reset_form_controller),
    // and a native reset never reaches TomSelect: without this, the board keeps
    // showing pieces the emptied <select> will no longer submit.
    // /!\ bind: removeEventListener needs the very same function object.
    this.clearOnReset = this.clearOnReset.bind(this)
    this.form = this.element.closest("form")
    this.form?.addEventListener("reset", this.clearOnReset)
  }

  disconnect() {
    this.form?.removeEventListener("reset", this.clearOnReset)
    this.select?.destroy()
  }

  // /!\ Clearing is only right because no option here is pre-selected. A form
  // whose options carry `selected` (the outfit edit form) would need the
  // selection restored, not wiped.
  clearOnReset() {
    this.select.clear()
    this.renderBoard()
  }

  renderRow(data, escape) {
    const name = escape(data.text)
    const thumb = data.thumb
    const visual = thumb
      ? `<img src="${escape(thumb)}" class="h-6 w-6 rounded object-cover ring-1 ring-zinc-200">`
      : `<span class="inline-flex h-6 w-6 items-center justify-center rounded bg-zinc-200 text-xs font-bold text-zinc-500">${escape(name.charAt(0).toUpperCase())}</span>`
    return `<div class="flex items-center gap-2">${visual}${name}</div>`
  }

  renderBoard() {
    this.boardTarget.innerHTML = ""
    this.select.items.forEach((id) => {
      const data = this.select.options[id]
      const name = this.escapeHtml(data.text)
      const thumb = data.thumb
      const visual = thumb
        ? `<img src="${this.escapeHtml(thumb)}" class="aspect-square w-full rounded object-cover">`
        : `<div class="flex aspect-square w-full items-center justify-center rounded bg-zinc-200 text-xl font-bold text-zinc-500">${name.charAt(0).toUpperCase()}</div>`
      const cell = document.createElement("div")
      cell.className = "relative"
      cell.innerHTML = `
        ${visual}
        <button type="button" data-action="click->garment-select#removePiece" data-id="${id}"
          class="absolute right-1 top-1 flex h-5 w-5 items-center justify-center rounded-full bg-zinc-900/70 text-xs text-white">&times;</button>
        <p class="mt-1 truncate text-center text-xs text-zinc-600">${name}</p>`
      this.boardTarget.appendChild(cell)
    })
  }

  removePiece(event) {
    const id = event.currentTarget.dataset.id
    this.select.removeItem(id)
  }

  escapeHtml(str) {
    const div = document.createElement("div")
    div.textContent = str
    return div.innerHTML
  }
}
