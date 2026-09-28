# HDI_4DVP_AutoRowHeight

A 4D **HDI** (How Do I) example demonstrating **automatic row height** for list box columns, a **4D View Pro** feature that lets a row grow to fit its tallest cell instead of clipping or scaling its content. Originally distributed as a binary `.4DB` database, it has been converted to the modern 4D project (`.4DProject`) architecture and modernised for current 4D language conventions with the help of **GitHub Copilot**.

## Overview

The demo form (`HDI2`) shows a four-column list box (`LB`: picture, name, short text, full text) populated from the `DOC` table. A panel of checkboxes lets you toggle **Automatic Row Height** for the whole list box or for each text/picture column individually, and toggle **word-wrap** per column, so you can see how row height adapts as content and wrapping change. A second panel lets you set explicit **minimum and maximum row heights**, in either lines or pixels, that cap how far automatic sizing can grow or shrink a row. A dropdown next to the picture column lets you switch between the seven picture display formats (truncated, scaled to fit, on background, replicated, ...) 4D View Pro supports, so you can see how each interacts with row height.

## Features

- **List-box-level and per-column auto row height** — `CB_AutoHeight` toggles `lk auto row height` for the whole `LB` list box; `CB_1_0`..`CB_1_3` toggle it independently for each column, via `LISTBOX SET PROPERTY`/`LISTBOX Get property`.
- **Per-column word-wrap** — `CB_2_1`..`CB_2_3` toggle `lk allow wordwrap` for the name/short-text/full-text columns, showing how wrapping and auto row height interact.
- **Min/max row height, in lines or pixels** — `vhMin`/`vhMax` input fields and a unit combo box drive `LISTBOX SET AUTO ROW HEIGHT`/`LISTBOX Get auto row height` with `lk row min height`/`lk row max height` and `lk lines`/`lk pixels`.
- **Picture display format** — a dropdown bound to `OBJECT SET FORMAT`/`OBJECT Get format` cycles the picture column through all seven 4D View Pro picture formats (truncated centered, scaled to fit, on background, replicated, ...).
- **Modern splash/startup flow** — the `00_Start` entry point uses `CALL WORKER`, a non-blocking `DIALOG(...;*)`, and window-reuse detection instead of spawning a new process or blocking on a modal dialog.
- **XLIFF localisation** — all user-facing menu, form, and message strings (including the picture-format and unit dropdown lists) are externalised to `Resources/{lang}.lproj/*.xlf` (English and Japanese), grouped by purpose (menus, per-form, messages).
- **Dark mode & Liquid Glass** — `styleSheets.css` uses `"automatic"`/`"automaticAlternate"` colour values and custom light/dark classes (e.g. the list box's odd-row tint) so the UI adapts to system appearance; `styleSheets_mac.css` sizes buttons correctly for macOS Tahoe's Liquid Glass appearance as well as classic rendering.
- **Modern method declarations** — all methods use `#DECLARE`/`var` typing instead of legacy `C_*` directives, with subroutines and form-dependent methods marked `invisible` so only real entry points show up in the Run Method dialog.
- **List box display defaults** — every column uses `"truncateMode": "none"` (no mid-word ellipsis) and the list box uses `"resizingMode": "legacy"` (only the last column grows on resize).

## Project structure

| Path | Contents |
|------|----------|
| `Project/Sources/Methods/00_Start.4dm` | Splash/startup entry point (worker dispatch, window reuse, non-blocking dialog). |
| `Project/Sources/Forms/HDI/` | Splash screen form, its `On Load` method (version/license gate), and the `BtnDemo` object method that opens the main demo. |
| `Project/Sources/Forms/HDI2/` | Main demo form: the `LB` list box, the auto-row-height/word-wrap checkboxes, the min/max row height fields, and the picture-format/unit dropdowns. |
| `Project/Sources/TableForms/1/` | Default input (`Form1`) and output forms for the `DOC` table used to seed and browse demo records. |
| `Project/Sources/menus.json` | Menu bar definition (File/Edit/Mode), using standard actions (e.g. `"action": "quit"`) where applicable. |
| `Project/Sources/styleSheets*.css` | Cross-platform and macOS/Windows-specific form stylesheets (dark mode, Liquid Glass button sizing). |
| `Resources/{lang}.lproj/*.xlf` | XLIFF translation files (English source + Japanese), grouped by menu/form/messages. |

## Points of interest

| File | Why it's worth reading |
|------|-------------------------|
| `Project/Sources/Forms/HDI2/form.4DForm` | The `LB` list box definition itself: four columns, each independently configurable for auto row height and word-wrap. |
| `Project/Sources/Forms/HDI2/method.4dm` | `On Load` handler that seeds the list box arrays from the `DOC` table and reads back the list box's current auto-row-height/word-wrap/min-max state to initialise the checkboxes and fields. |
| `Project/Sources/Forms/HDI2/ObjectMethods/CB_AutoHeight.4dm`, `CB_1_0.4dm` | The list-box-level vs. per-column `LISTBOX SET PROPERTY(...; lk auto row height; ...)` pattern, and how toggling one refreshes the others. |
| `Project/Sources/Forms/HDI2/ObjectMethods/vhMin.4dm`, `Combo Box1.4dm` | `LISTBOX SET AUTO ROW HEIGHT`/`LISTBOX Get auto row height` with a unit selector (`Choose` between `lk lines`/`lk pixels`), including the min/max clamp (`If (vhMin>vhMax) vhMax:=vhMin`). |
| `Project/Sources/Methods/00_Start.4dm` | The splash/startup pattern: worker dispatch, window reuse, non-blocking dialog. |
| `Project/Sources/Forms/HDI/method.4dm` | The version/license gate (`Is license available(4D View license)`) that disables the demo and swaps in a "Close" button when no valid 4D View Pro license is present — preserved as-is since it's the actual subject of the demo, not incidental legacy code. |
| `Project/Sources/styleSheets.css`, `styleSheets_mac.css` | Dark mode and Liquid Glass adaptation via `prefers-color-scheme`/`form-theme` media queries, including a custom light/dark odd-row tint for the list box. |
| `Resources/*.lproj/*.xlf` | XLIFF localisation structure (menus, per-form, messages), in English and Japanese. |

## Modernisation notes

Beyond the auto-row-height demo itself, the codebase has been brought up to current 4D conventions:

- **Localisation** — all menu titles, form text/labels, and message strings (including dropdown list items built at runtime) use `:xliff:` references or `Localized string(...)`, backed by XLIFF files under `Resources/`.
- **Modern variable declarations** — legacy `C_LONGINT`/`C_TEXT`/etc. directives have been replaced with `var`/`#DECLARE` project-wide, including the `Compiler_*.4dm` typing files.
- **Standard menu actions** — the one-line `m_Quit` wrapper method was removed in favor of the built-in `"action": "quit"`.
- **Method visibility** — project methods were audited; the existing set was already correctly configured (subroutines/typing files `invisible`, `00_Start` visible).
- **Modern startup pattern** — `#DECLARE`, `CALL WORKER` (instead of `New process`), and non-blocking `DIALOG(...; *)`; the obsolete v16 version-check branch was removed, while the functionally meaningful 4D View Pro license check was kept.
- **Dark mode & Liquid Glass** — forms use `"automatic"`/`"automaticAlternate"` colors and `prefers-color-scheme`/`form-theme` media queries instead of hardcoded hex colors, so the UI adapts to system appearance and to macOS Tahoe's Liquid Glass button styling.
- **List boxes** — `"truncateMode": "none"` and `"resizingMode": "legacy"` applied to the `LB` list box and all of its columns.

## Requirements

- 4D 21.1 or later (project uses `compatibilityVersion: 2101`).
- A valid 4D View / 4D View Pro license — checked at startup via `Is license available` and enforced by the splash screen.

## Getting started

1. Open `Project/HDI_4DVP_AutoRowHeight.4DProject` in 4D.
2. Run the `00_Start` method (or use the **File > Demo...** menu item) to open the splash screen, then click **Demo** to open the main window.
3. Toggle **Auto Row Height** at the list box level or per column, toggle word-wrap per column, and edit a record's short/full text to see rows resize.
4. Set explicit **Min**/**Max** row heights (in lines or pixels) to cap how far automatic sizing can grow or shrink.
5. Change the picture column's display format to see how each format behaves once auto row height is enabled.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16 R5. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (syntax, localisation, dark mode) with the help of **GitHub Copilot**.

- **Blog post:** https://blog.4d.com/automatic-row-height-in-listboxes-a-new-4d-view-pro-feature/
- **Original download:** https://downloads.4d.com/Demos/4D_v16_R5/HDI_4DVP_AutoRowHeight.zip

## References

- `LISTBOX SET AUTO ROW HEIGHT`: https://developer.4d.com/docs/commands/listbox-set-auto-row-height
- `LISTBOX Get auto row height`: https://developer.4d.com/docs/commands/listbox-get-auto-row-height
- `LISTBOX SET PROPERTY` / `LISTBOX Get property`: https://developer.4d.com/docs/commands/listbox-set-property / https://developer.4d.com/docs/commands/listbox-get-property
- List box column/row properties reference: https://developer.4d.com/docs/FormObjects/propertiesReference
- CSS in 4D (dark mode, Liquid Glass): https://developer.4d.com/docs/FormEditor/stylesheets
- XLIFF localisation (`Localized string`): https://developer.4d.com/docs/commands/localized-string
