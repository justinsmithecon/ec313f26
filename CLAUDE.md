# EC313 — Taxation: Claude Project Memory

## Project Overview
This is the Quarto-based course website for **EC313 (Public Economics: Taxation)** at Wilfrid Laurier University, taught by Justin Smith. It uses Reveal.js for slide decks and publishes to `docs/`.

## Directory Structure
```
slides/         # Reveal.js slide decks (one subfolder per lecture)
content/        # Course content pages (.qmd)
assignments/    # Assignment files
files/          # Supporting files (PDFs, datasets, images)
_variables.yml  # Course-level variables (semester, instructor, schedule)
_quarto.yml     # Quarto project configuration
```

---

## Slide Decks

Each deck lives at `slides/<name>/index.qmd`, with `hygge.scss`, `captions.css`, and an `images/` subfolder.

### Decks that receive full formatting + clarity updates each semester
| Deck | Topic |
|------|-------|
| `intro` | Introduction |
| `incidence` | Tax Incidence |
| `efficiency` | Efficiency and Excess Burden |
| `equitable` | Equitable Taxation |
| `personaltax` | Personal Income Tax |
| `taxbehaviour` | Taxation and Behaviour |
| `corptax` | Corporate Taxation |
| `constax` | Consumption Taxation |
| `externalities` | Externalities and Environmental Taxation |

---

## New Semester Update Workflow

### Step 1 — Update `_variables.yml`
Change `course.semester`, `course.dates`, `course.copyright_year`, and any scheduling fields.

### Step 2 — Update the title slide in each edited deck
In `slides/<name>/index.qmd`, change:
```html
<h2>Fall 20XX</h2>   →   <h2>Fall 20XX</h2>
```
Also fix the hex logo position on the title slide if needed:
```
{.absolute top="300" ...}   →   {.absolute top="275" ...}
```

Look for any hard-coded dates and update them too

### Step 3 — Apply formatting & clarity changes to all 9 decks
Use the previous semester's versions as the reference. The previous semester (Fall 2025) lives in the sibling repo at `../ec313f25`; compare against it to check what has been changed relative to the original versions.

---

## Formatting Conventions for Edited Decks

See the shared formatting guide at `../../shared/slide-formatting.md` for all style rules (goals sections, bullet formatting, highlighted key terms, callout boxes, column layouts).

---

## Previous Semester Reference
The previous semester's site (Fall 2025) is the sibling repo/folder `../ec313f25`. This repo began as the `ec313f26` branch of that repo, so histories are shared up to the branch point. To compare slides between semesters:
The branch point is tagged `fall2025`, so use:
```bash
git diff fall2025 -- slides/
```

### Step 4 - Check the slides for any inaccuracies and create a document that outlines them
