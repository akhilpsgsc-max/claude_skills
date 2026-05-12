---
name: refactor
description: >
  Use this skill whenever the user wants to refactor code, clean up a codebase, fix duplication,
  extract shared code, consolidate repeated logic, remove dead code, or improve code structure
  WITHOUT changing what the code does. Trigger on phrases like "refactor", "clean up", "extract",
  "too much duplication", "shared stylesheet", "centralise", "DRY this up", "split this file",
  "hardcoded values", "N+1", "repeated fetch", "pages have different themes", "each page has its
  own CSS", "this keeps drifting", or any situation where code is copied across files when it
  should be shared. Also trigger when a new file is created and its styling/logic visibly drifts
  from the rest of the project — that's a refactor signal even if the user doesn't name it.
  Use this skill proactively: if you notice duplication or drift while working on another task,
  flag it and offer to run a refactor.
---

# Refactor

Refactoring means restructuring existing code to make it cleaner and easier to maintain —
without changing what it does. Same behaviour, better internals.

This skill covers six common workflows. Each one follows the same three-step pattern:
**audit → execute → prevent recurrence**.

---

## Step 1 — Identify which workflow applies

Read the relevant files and run the appropriate audit before touching anything.
If multiple workflows apply, list them all and handle the highest-impact one first.

| Workflow | Signal |
|---|---|
| **A. Extract shared CSS** | Multiple HTML files each have a `<style>` block with the same variables, sidebar, nav, or button styles |
| **B. Extract shared JS** | Same helper functions or constants copy-pasted across JS files |
| **C. Consolidate API calls** | A loop does a fetch/query per item instead of one bulk fetch (N+1 pattern) |
| **D. Split large file** | A single file is doing multiple unrelated jobs and is hard to navigate (>400–500 lines is a signal, not a rule) |
| **E. Remove dead code** | Commented-out blocks, unused functions, unreachable routes, or variables that are set but never read |
| **F. Extract constants** | The same hardcoded value (URL, limit, key, threshold) appears in multiple places |

---

## Workflow A — Extract shared CSS

**When:** Multiple HTML pages each have a large inline `<style>` block with duplicated design tokens, sidebar/nav styles, button styles, or typography. The symptom is theme drift — a new page looks different because whoever built it copied the wrong source page.

**Audit first:**
- List every `.html` file and how many lines of inline CSS each has
- Identify which CSS blocks appear in 2+ files (CSS variables, `.sidebar`, `.nav-item`, `.btn`, `.badge`, form elements, typography)
- Note any *differences* between copies — these need to stay per-page

**Execute:**
1. Create a shared stylesheet (e.g., `static/styles.css` if it doesn't exist)
2. Move the common blocks there — start with CSS custom properties (`:root { --vars }`), then layout primitives, then shared components (sidebar, nav, buttons, badges, form elements, toast, modals)
3. Add `<link rel="stylesheet" href="styles.css">` to every HTML page, *before* any remaining inline styles
4. Strip the moved CSS from each page's inline `<style>` — leave only page-specific styles
5. Verify visually: the page should look identical before and after

**What to keep inline:** Styles unique to one page (specific table layouts, page-specific tabs, unique components). Don't over-extract — if something only appears on one page, leave it there.

---

## Workflow B — Extract shared JS

**When:** The same helper function, constant, or class is copy-pasted across multiple JS files or `<script>` blocks.

**Audit first:**
- Search for function names or constants that appear in 2+ files
- Check if a shared module already exists (e.g., `insights.js`, `main.js`) that this should live in

**Execute:**
1. Create a shared module if one doesn't exist (e.g., `static/utils.js`)
2. Move the shared code there with a clear export or global declaration
3. Add `<script src="utils.js"></script>` to each page that needs it, before the page's own script block
4. Remove the duplicated copies from each page
5. Confirm nothing breaks — run the app and exercise the affected paths

---

## Workflow C — Consolidate API / DB calls (N+1)

**When:** A loop makes a fetch or database query per item, when one bulk query could return everything.

**Pattern to look for:**
```js
// N+1 — bad
for (const item of items) {
  const result = await db.query(`SELECT ... WHERE id = '${item.id}'`);
}

// Bulk — good
const existing = await db.query(`SELECT ... WHERE allocation_id = '${allocId}' LIMIT 0, 200`);
const map = buildLookupMap(existing);
for (const item of items) { /* use map */ }
```

**Execute:**
1. Move the query outside the loop — fetch all relevant rows in one call
2. Build an in-memory lookup map (keyed by ID or composite key)
3. Replace per-item queries with map lookups inside the loop
4. Add a comment explaining why the pre-fetch exists (required by project rule)

---

## Workflow D — Split a large file

**When:** A single file has grown to handle multiple unrelated responsibilities, making it hard to navigate or test independently. Size alone isn't the reason — the reason is mixed concerns.

**Audit first:**
- List the distinct responsibilities the file currently handles
- Identify natural split points (e.g., route groups, feature areas, utility vs. business logic)

**Execute:**
1. Create new files for each responsibility
2. Move code without changing its logic
3. Update all imports/requires
4. Delete the original or reduce it to an entry point that imports the new modules

---

## Workflow E — Remove dead code

**When:** There are commented-out blocks that haven't been touched in a long time, functions that are defined but never called, unreachable routes, or variables set but never read.

**Be conservative:** Only remove code you are certain is unused. If there's any doubt, leave it and add a `// TODO: confirm unused before removing` comment.

**Execute:**
1. List every dead block with its location before removing anything
2. Confirm each one is genuinely unreachable or unused
3. Remove and note in the commit message what was removed and why you're confident it's safe

---

## Workflow F — Extract constants

**When:** The same value (a URL, a numeric threshold, a table name, an environment key) appears hardcoded in multiple places.

**Execute:**
1. Define the constant once at the top of the relevant file or in a shared config
2. Replace all occurrences with the named constant
3. Name it clearly — `MAX_ROWS`, `API_BASE_URL`, `LOAD_THRESHOLD_OVERLOADED`

---

## Step 3 — Prevent recurrence

After every refactor, add a rule to `CLAUDE.md` in the project root that explains:
- What pattern was fixed
- What to do instead in future
- Why it matters

Keep it to 1–2 lines. The goal is that the next Claude session (or developer) hits the rule before they repeat the mistake.

**Example rules:**
```
Never add inline CSS for sidebar, nav, buttons, or design tokens — these live in styles.css.
Never add a per-item DB query inside a loop — pre-fetch the full set and use an in-memory map.
Never hardcode API_URL or MAX_ROWS — they are defined in the constants block at the top of index.js.
```

---

## Principles

**Always run in the project directory.** All reads and writes happen on real project files — not simulated copies. The audit step reads actual source files; the execute step edits them in place.

**Don't change behaviour.** If you're not sure whether a change is safe, don't make it. Refactoring has a strict contract: identical output for identical input.

**Audit before you touch anything.** List what you found before making changes. This catches surprises and gives the user a chance to redirect.

**One workflow per commit.** Each refactor type should be a separate commit with a clear message: `refactor: extract shared CSS into styles.css` not `cleanup`.

**Explain the why in CLAUDE.md, not just the what.** "Don't copy sidebar CSS" is worse than "Don't copy sidebar CSS — theme drift across pages has happened twice; styles.css is the single source of truth."
