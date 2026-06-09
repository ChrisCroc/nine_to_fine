# Color Selector (Tom Select) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.
>
> **Coaching mode note:** In this repo, Chris implements code himself (mode coach). This plan is the reference he follows — every step contains the exact code to write and the exact command to run.

**Goal:** Replace the free-text `text_field :color` in the Garment form with a `<select>` enhanced by Tom Select that renders a coloured dot next to each colour name, while keeping the existing validation chain intact.

**Architecture:** A frozen `Garment::COLOR_HEX` hash maps each entry of `Garment::COLORS` to its Tailwind v4 shade-500 hex value. A dedicated Stimulus controller `color-select` instantiates Tom Select with a custom `render` function that injects a coloured dot from the `data-hex` attribute carried by each `<option>`. A Minitest invariant prevents future drift between `COLORS` and `COLOR_HEX` keys.

**Tech Stack:** Rails 8.1, Stimulus (importmap), Tom Select (already pinned via importmap-rails since PR #55 sem 23), Tailwind CSS v4 (via tailwindcss-rails standalone), Minitest.

---

## File Structure

- **Modify:** `app/models/garment.rb` — add `COLOR_HEX` constant under the existing `COLORS` constant.
- **Modify:** `test/models/garment_test.rb` — add 1-line invariant test asserting `COLORS == COLOR_HEX.keys`.
- **Create:** `app/javascript/controllers/color_select_controller.js` — Stimulus controller, ~25 lines. Separate from `select_controller.js` (Outfit combobox) to keep configs distinct.
- **Modify:** `app/views/garments/_form.html.erb` lines 11-17 — replace `f.text_field :color` block with `f.select :color, ...` carrying `data-controller="color-select"` and a `data-hex` per option.

No other file touched. The controller (`GarmentsController#new`, `#edit`, `#create`, `#update`) stays untouched — `:color` is already permitted in `garment_params` since the original CRUD (sem 22).

---

## Task 1: Add `COLOR_HEX` constant + invariant test

**Files:**
- Modify: `app/models/garment.rb`
- Modify: `test/models/garment_test.rb`

- [ ] **Step 1: Write the failing test**

In `test/models/garment_test.rb`, add this test inside the existing `class GarmentTest < ActiveSupport::TestCase` block (anywhere before the final `end`):

```ruby
test "COLOR_HEX maps every entry of COLORS" do
  assert_equal Garment::COLORS.sort, Garment::COLOR_HEX.keys.sort,
    "Each colour in COLORS must have a hex value in COLOR_HEX (drift detected)."
end
```

The custom failure message names the invariant explicitly so a future maintainer who adds a colour to `COLORS` immediately sees what's wrong.

- [ ] **Step 2: Run the test to verify it fails**

Run:
```
bin/rails test test/models/garment_test.rb -n test_COLOR_HEX_maps_every_entry_of_COLORS
```

Expected output: **FAIL** with `NameError: uninitialized constant Garment::COLOR_HEX`.

This proves the test is reaching the constant (not a typo in `COLORS`) and that the test will catch the absence of `COLOR_HEX` once the next steps add it.

- [ ] **Step 3: Add the `COLOR_HEX` constant**

In `app/models/garment.rb`, just under the existing `COLORS = %w[...].freeze` line, add:

```ruby
COLOR_HEX = {
  "black"  => "#000000",
  "white"  => "#ffffff",
  "grey"   => "#6b7280",   # Tailwind gray-500
  "beige"  => "#d6c1a3",   # custom (Tailwind has no native beige; close to stone-300 darkened)
  "brown"  => "#a16207",   # Tailwind amber-700 (Tailwind has no native brown)
  "red"    => "#ef4444",   # Tailwind red-500
  "orange" => "#f97316",   # Tailwind orange-500
  "yellow" => "#eab308",   # Tailwind yellow-500
  "green"  => "#22c55e",   # Tailwind green-500
  "blue"   => "#3b82f6",   # Tailwind blue-500
  "purple" => "#a855f7",   # Tailwind purple-500
  "pink"   => "#ec4899"    # Tailwind pink-500
}.freeze
```

The `.freeze` mirrors the `.freeze` already on `COLORS`. The comments document the source of each hex so a future maintainer can verify or tweak (especially `beige` and `brown` which aren't standard Tailwind names).

- [ ] **Step 4: Run the test to verify it passes**

Run:
```
bin/rails test test/models/garment_test.rb -n test_COLOR_HEX_maps_every_entry_of_COLORS
```

Expected output: **PASS** (1 run, 1 assertion, 0 failures).

- [ ] **Step 5: Run the full Garment model test file to confirm no regression**

Run:
```
bin/rails test test/models/garment_test.rb
```

Expected output: all previous tests still pass plus the new one. No new failures.

- [ ] **Step 6: Commit**

```
git add app/models/garment.rb test/models/garment_test.rb
git commit -m "feat(garment): add COLOR_HEX hash + invariant test"
```

---

## Task 2: Create the `color-select` Stimulus controller

**Files:**
- Create: `app/javascript/controllers/color_select_controller.js`

No automated test — Stimulus controllers are tested by integration (system tests via Capybara), which are deferred to the RSpec setup planned for wednesday 10 june. Manual browser verification is the discipline for this step.

- [ ] **Step 1: Create the controller file**

Create `app/javascript/controllers/color_select_controller.js` with exactly this content:

```js
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
        item:   (data, escape) => this.renderRow(data, escape)
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
```

Justification per block:
- `import TomSelect from "tom-select"` — already pinned in `config/importmap.rb` since PR #55, no new pin needed.
- `dropdownParent: "body"` — prevents the dropdown from being clipped inside parent containers with `overflow: hidden` (same fix already applied in `select_controller.js`).
- `render: { option, item }` — `option` styles each row inside the dropdown; `item` styles the selected value visible when the dropdown is closed. Both use the same `renderRow` helper to avoid duplication.
- `escape(data.hex || "#cccccc")` — the fallback `#cccccc` (light grey) shows up if a colour has no mapped hex (drift caught by the invariant test, but graceful degradation if test was bypassed).
- `escape(data.text)` — Tom Select's built-in XSS escape applied to user-controlled strings (the labels come from our curated `COLORS` array but defense in depth costs nothing).
- `this.select?.destroy()` — safe navigation in case `connect()` crashed before assignment, avoiding a `TypeError: Cannot read property 'destroy' of undefined`.
- `flex items-center gap-2` + `inline-block w-3 h-3 rounded-full ring-1 ring-zinc-300` — Tailwind utility classes. The `ring-1 ring-zinc-300` is critical: without it, the `white` pastille (`#ffffff`) is invisible on the white dropdown background.

- [ ] **Step 2: Verify Stimulus auto-registers the controller**

Eager loading is active in `app/javascript/controllers/index.js` (confirmed during the search bar session earlier today), so just creating the file is enough — no `index.js` edit.

Restart the Rails server if it's running (to pick up the new JS file in importmap's runtime):
```
# In the terminal running bin/rails server, hit Ctrl+C, then:
bin/rails server
```

In a browser, open `http://localhost:3000/garments/new`. Open DevTools Console and type:
```
Stimulus.controllers.map(c => c.identifier)
```

Expected output: an array containing `"color-select"` (alongside `"select"`, etc.). If `"color-select"` is absent, the controller file isn't being picked up — check the filename matches exactly `color_select_controller.js` (underscores, lowercase, trailing `_controller`).

- [ ] **Step 3: Commit**

The controller renders nothing yet because the form view doesn't carry `data-controller="color-select"` — the next task wires it. Still commit now to keep changes atomic per concern.

```
git add app/javascript/controllers/color_select_controller.js
git commit -m "feat(stimulus): add color-select controller with Tom Select dot rendering"
```

---

## Task 3: Wire the form `<select>` with `data-hex` per option

**Files:**
- Modify: `app/views/garments/_form.html.erb` lines 11-17

No automated test — UI rendering, validated by browser inspection.

- [ ] **Step 1: Replace the `text_field :color` block with a `select`**

In `app/views/garments/_form.html.erb`, find this block (currently lines 11-17):

```erb
<div class="mb-4">
  <%= f.label :color, class: "block text-sm font-medium text-zinc-700 mb-1" %>
  <%= f.text_field :color, class: "block w-full rounded-md border border-zinc-300 px-3 py-2 text-zinc-900 shadow-sm focus:border-zinc-500 focus:ring-2 focus:ring-zinc-500 focus:outline-none" %>
  <% if garment.errors[:color].any? %>
    <span class="block text-sm text-red-600 mt-1"><%= garment.errors[:color].first %></span>
  <% end %>
</div>
```

Replace with:

```erb
<div class="mb-4">
  <%= f.label :color, class: "block text-sm font-medium text-zinc-700 mb-1" %>
  <%= f.select :color,
        Garment::COLORS.map { |c| [c.capitalize, c, { "data-hex": Garment::COLOR_HEX[c] }] },
        { prompt: "Choose a color" },
        { class: "block w-full rounded-md border border-zinc-300 px-3 py-2 text-zinc-900 shadow-sm focus:border-zinc-500 focus:ring-2 focus:ring-zinc-500 focus:outline-none",
          data: { controller: "color-select" } } %>
  <% if garment.errors[:color].any? %>
    <span class="block text-sm text-red-600 mt-1"><%= garment.errors[:color].first %></span>
  <% end %>
</div>
```

Anatomy of the `f.select` call (4 arguments, all required to land in the right place):

1. **`:color`** — the model attribute name. Generates `name="garment[color]"` and `id="garment_color"`.
2. **`Garment::COLORS.map { |c| [c.capitalize, c, { "data-hex": Garment::COLOR_HEX[c] }] }`** — the choices. Each element is a 3-tuple `[label, value, html_options]`:
   - `c.capitalize` = the user-facing label ("Red"), Title Case for UI.
   - `c` = the stored value ("red"), lowercase to match `COLORS` and the `inclusion` validation.
   - `{ "data-hex": Garment::COLOR_HEX[c] }` = the data attribute injected onto the `<option>` tag. This is what Tom Select reads via `data.hex` in `renderRow`.
3. **`{ prompt: "Choose a color" }`** — the **options** hash (not the html options). `prompt` shows a blank-value first row that's not a valid choice. This is the **3rd** argument; mixing it with the 4th would silently drop the data-controller.
4. **`{ class: "...", data: { controller: "color-select" } }`** — the **html_options** hash. This is what sets attributes on the `<select>` tag itself. `data-controller="color-select"` is what wires the Stimulus controller; without it, no Tom Select.

The error display block (`<% if garment.errors[:color].any? %>`) is unchanged — same partial style as `:name`, `:category_id`, etc.

- [ ] **Step 2: Verify the `<select>` renders with `data-hex` on each option**

In a browser, open `http://localhost:3000/garments/new`. Right-click on the field labelled "Color" → Inspect.

Expected DOM:
```html
<select name="garment[color]" id="garment_color" class="block w-full ..." data-controller="color-select">
  <option value="">Choose a color</option>
  <option value="black" data-hex="#000000">Black</option>
  <option value="white" data-hex="#ffffff">White</option>
  <option value="grey" data-hex="#6b7280">Grey</option>
  ...
</select>
```

If `data-hex` is missing on the options, the `Garment::COLORS.map` block in step 1 is wrong — most likely the html_options hash (3rd element of the tuple) is malformed.

- [ ] **Step 3: Verify Tom Select takes over and renders the dots**

In the same browser tab, click on the "Color" field. The dropdown should open and each option should display:

```
[●]  Black
[●]  White
[●]  Grey
...
[●]  Pink
```

Where `[●]` is a 12px circle filled with the corresponding hex colour, with a thin grey ring around it.

If the dropdown shows plain text without dots:
- Open DevTools Console, look for any error like `TomSelect is not defined` (importmap issue) or `Cannot read property 'hex' of undefined` (data-hex missing on options).
- If no error, type `document.querySelector('#garment_color').tomselect` in the console — if it returns `undefined`, Stimulus didn't connect.

If the dropdown shows dots but the white pastille is invisible: the `ring-1 ring-zinc-300` class wasn't applied — check Task 2 step 1 code matches exactly.

- [ ] **Step 4: Commit**

```
git add app/views/garments/_form.html.erb
git commit -m "feat(garment): wire colored dropdown selector on form _form.html.erb"
```

---

## Task 4: End-to-end manual verification

**Files:** none modified.

This task is the 6-point manual verification checklist from the spec. Run each in order; if any fails, diagnose and fix before committing the polishing changes.

- [ ] **Step 1: New form — visual check**

Open `http://localhost:3000/garments/new`. Verify:
- The "Color" field shows a dropdown (no longer a plain text input).
- Clicking the dropdown opens it with 12 options, each prefixed by a coloured dot.
- The "White" option's dot is visible (ring-1 makes it stand out on white background).
- The placeholder reads "Choose a color".

- [ ] **Step 2: Create a garment with a coloured selection**

Fill the form:
- Name: `"Test red shirt"` (any string)
- Color: select "Red" (the dot should turn red and the label "Red" should appear in the visible value)
- Description: anything
- Category: any
- Submit ("Create Garment" or whatever the button label is).

Expected: redirect to the new garment's show page with success flash. The garment record exists.

- [ ] **Step 3: Verify the DB value via Rails console**

In a separate terminal:
```
bin/rails console
```

Then:
```ruby
Garment.last.color
```

Expected output: `"red"` (string, lowercase). Confirms the stored value matches the `COLORS` palette and would pass the `inclusion` validation on re-save.

Type `exit` to leave the console.

- [ ] **Step 4: Edit the same garment — verify the dropdown pre-fills**

Open `http://localhost:3000/garments/<id>/edit` (using the id of the garment created in step 2).

Expected: the "Color" field shows a red dot + "Red" as the currently selected value. The dropdown isn't open by default but clicking it opens it with all options.

- [ ] **Step 5: Change the colour, submit, verify update**

Change the colour to "Blue" (blue dot should appear). Submit.

Open `bin/rails console` again:
```ruby
Garment.find(<id>).color
```

Expected: `"blue"`.

- [ ] **Step 6: Graceful degradation — JS disabled**

In DevTools: open Settings (F1 or click the gear icon), find "Debugger", check "Disable JavaScript". Reload `http://localhost:3000/garments/new`.

Expected: the native `<select>` renders as a plain dropdown (no Tom Select styling, no coloured dots). Selecting an option and submitting still works — the colour is saved correctly.

Re-enable JavaScript when done.

- [ ] **Step 7: Final commit (if any tweaks needed during verification)**

If any of the above steps required a code fix (hex value adjusted, CSS class added, etc.):
```
git add <files>
git commit -m "fix(garment): adjust <what> after manual verification"
```

If everything passed without tweaks, no extra commit needed.

---

## Self-Review (done by Claude before handoff)

**Spec coverage check:**
- Unit 1 `Garment::COLOR_HEX` → Task 1 ✅
- Unit 2 `color_select_controller.js` → Task 2 ✅
- Unit 3 form view modification → Task 3 ✅
- Unit 4 CSS pastille (inline Tailwind utilities) → embedded in Task 2 step 1 ✅
- Test invariant `COLORS == COLOR_HEX.keys` → Task 1 step 1 ✅
- 6-point manual verification checklist → Task 4 ✅
- 5 anticipated risks → each addressed in step justifications or the Task 4 graceful-degradation step ✅

**Placeholder scan:** no "TBD", "TODO", "fill in later", "implement appropriate error handling". Every step has the exact code or command needed.

**Type consistency:** controller identifier `"color-select"` matches data attribute `data-controller="color-select"` and filename `color_select_controller.js` (kebab/snake mapping per Stimulus convention). Hash key access pattern `Garment::COLOR_HEX[c]` consistent throughout.

---

## Execution notes (coaching mode)

In this repo, Chris writes the code. This plan is his step-by-step reference. Each step's code block is the source of truth — copy it into the right file, run the command, verify the output.

The `superpowers:subagent-driven-development` and `superpowers:executing-plans` sub-skills are **not invoked** because there is no autonomous agent executing the plan in this session. If a different session later needs to execute it autonomously, those sub-skills can be invoked then.

**Estimated total time:** ~30 minutes (5 min Task 1 + 10 min Task 2 + 10 min Task 3 + 5 min Task 4 happy path).
