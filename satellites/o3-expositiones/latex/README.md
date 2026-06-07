# LaTeX harness — Expositiones satellite (O3)

*LaTeX deliverables for the Expositiones Mathematicae Short Research Note submission. Compiled from [`../01-manuscript.md`](../01-manuscript.md) (Draft 0.1) per the strategy memo at [`../00-strategy.md`](../00-strategy.md).*

---

## Files

| File | Purpose |
|---|---|
| [`manuscript.tex`](manuscript.tex) | LaTeX source (Elsevier `elsarticle` class) |
| [`refs.bib`](refs.bib) | BibTeX bibliography (numerical style, citation-order via `elsarticle-num`) |
| [`highlights.txt`](highlights.txt) | Article highlights (5 bullets, each ≤85 chars; Elsevier-encouraged) |
| [`build.ps1`](build.ps1) | Windows PowerShell build harness with mode switching |
| [`build.sh`](build.sh) | POSIX (Linux/macOS/WSL) build harness, equivalent functionality |

---

## Quick start

### Windows (PowerShell)

```powershell
./build.ps1                 # builds reading mode (default)
./build.ps1 -Mode review    # builds the SUBMISSION pdf (line-numbered, double-spaced)
./build.ps1 -Mode final     # builds the publisher-typeset preview
./build.ps1 -Clean          # remove all build artifacts
```

### Linux / macOS / WSL (bash)

```bash
chmod +x build.sh
./build.sh                      # builds reading mode (default)
./build.sh --mode review        # builds the SUBMISSION pdf
./build.sh --mode final         # builds the publisher-typeset preview
./build.sh --clean              # remove all build artifacts
```

### Manual

```bash
pdflatex manuscript
bibtex   manuscript
pdflatex manuscript
pdflatex manuscript
```

The harness adds: toolchain validation, mode switching (reading / review / final), clean failure reporting, summary table (PASS/FAIL + page count + word count), and a page-count gate for submission mode (warns if exceeding the Expositiones 10-page limit for Short Research Notes).

---

## Compilation modes

The `manuscript.tex` file has three documentclass lines at the top, two commented out. The build script automatically toggles them based on the requested mode.

| Mode | `\documentclass` option | Use case |
|---|---|---|
| **reading** (default) | `preprint,12pt,a4paper` | Author reading copy — single column, no line numbers, clean |
| **review** | `review,12pt,a4paper` | **The submission PDF** — single column, double-spaced, line-numbered |
| **final** | `1p,12pt,a4paper,times,authoryear` | Preview of what the publisher-typeset version looks like |

**For EES dispatch, build the `review` mode** — Elsevier prefers line-numbered double-spaced PDFs at the review stage.

---

## Toolchain requirements

| Tool | Purpose | Install |
|---|---|---|
| `pdflatex` | LaTeX→PDF compilation | MiKTeX (Windows), TeX Live (Linux), MacTeX (macOS) |
| `bibtex` | Bibliography processing | (bundled with the above) |
| `elsarticle` class | Elsevier class file | Bundled in TeX Live "full", in MiKTeX (auto-install on first use) |
| `pdfinfo` | (optional) PDF page count for the summary | bundled with poppler-utils |

**Required LaTeX packages** (all standard, in TeX Live "full" install):
- `elsarticle` (Elsevier class)
- `amsart`-family: `amssymb`, `amsmath`, `amsthm`
- `microtype`, `hyperref`, `booktabs`, `array`, `tabularx`
- `inputenc[utf8]`, `fontenc[T1]`

The `elsarticle` class is bundled with most full TeX distributions. If you need to install it manually:

- **MiKTeX:** the class auto-installs on first use; or open MiKTeX Console → Packages → search "elsarticle" → install.
- **TeX Live:** `tlmgr install elsarticle`.
- **Direct:** download from CTAN at <https://ctan.org/pkg/elsarticle>.

---

## Output

After a successful build:

```
manuscript.pdf       # the compiled manuscript (mode-dependent layout)
manuscript.bbl       # processed bibliography (Elsevier numerical style)
+ various build artifacts (.aux, .log, .out, etc.)
```

The `manuscript.pdf` is the submission file. The `manuscript.bbl` may also be useful at submission time (some publishers prefer to receive both the `.bib` and the processed `.bbl`).

---

## Submission package contents (per [`../99-submission-checklist.md`](../99-submission-checklist.md) §2)

| File | Format | Source |
|---|---|---|
| `manuscript.tex` | LaTeX source | this folder |
| `manuscript.pdf` | Compiled PDF (review mode) | produced by `./build.ps1 -Mode review` |
| `refs.bib` | BibTeX bibliography | this folder |
| `highlights.txt` | Article highlights | this folder |
| `declaration-of-interests.docx` | Word file (Elsevier-mandated separate upload) | created by author from [`../00-strategy.md`](../00-strategy.md) §6 template |

Per the Expositiones author guidelines, Elsevier prefers LaTeX submissions over Word. The submission file set above is the complete Elsevier-required package.

---

## Pre-flight checks before EES dispatch

Run `./build.ps1 -Mode review` (or `./build.sh --mode review`) and verify:

- [ ] `HARNESS: PASS` reported
- [ ] `manuscript.pdf` exists and opens correctly
- [ ] Page count is **≤ 10** (Expositiones Short Research Note hard limit)
- [ ] Word count is in the expected range (~3500–5000 body words)
- [ ] No `[AUTHOR]` placeholder remaining: `grep -n "\[AUTHOR\]" *.tex *.bib`
- [ ] No `[INSTITUTION` placeholder remaining: `grep -n "\[INSTITUTION" *.tex`
- [ ] All references resolve (no `[?]` warnings in `manuscript.log`)
- [ ] Highlights file has 5 lines, each ≤85 chars: `awk '{print length, $0}' highlights.txt`
- [ ] AI declaration text matches the author's actual AI usage (see [`../00-strategy.md`](../00-strategy.md) §5)
- [ ] Funding text matches the author's actual funding status (see [`../00-strategy.md`](../00-strategy.md) §7)
- [ ] `declaration-of-interests.docx` has been created from the template (see [`../00-strategy.md`](../00-strategy.md) §6)

The [`../99-submission-checklist.md`](../99-submission-checklist.md) walks through the full submission-day procedure.

---

## Troubleshooting

### "File `elsarticle.cls' not found"
Install the Elsevier class:
- **MiKTeX:** the class auto-installs on first use of `\documentclass{elsarticle}`. If auto-install is disabled, open MiKTeX Console → Packages → install `elsarticle`.
- **TeX Live:** `tlmgr install elsarticle`.

### `highlights.txt` lines too long
Elsevier's hard cap is 85 characters per highlight (including spaces). Check with:
```bash
awk '{print length, $0}' highlights.txt
```
Each line should report `≤85`.

### Build script complains about mode switching
The `Set-DocumentMode` / `set_document_mode` functions modify `manuscript.tex` in place. If you see errors, manually edit `manuscript.tex` to uncomment exactly one of the three `\documentclass` lines and comment the other two.

### PDF page count exceeds 10
The Short Research Note category has a 10-page hard limit. If your PDF exceeds 10 pages:
- Try compressing whitespace in the abstract or introduction.
- Move discursive content from §5 to a footnote or shorter inline mention.
- Consider whether some content belongs in a supplementary file (Elsevier allows supplementary materials).
- As a last resort, re-target the **Main Research Article** category (≥15 pages, no upper limit) and expand rather than compress.

### "Undefined control sequence \highlights"
The `\highlights` environment is provided by the `elsarticle` class. If it's missing, your `elsarticle` install is incomplete; reinstall via the package manager.

---

## Hand-off to the submission day

The LaTeX harness is the last engineering deliverable. The next step is the operational pre-flight at [`../99-submission-checklist.md`](../99-submission-checklist.md): author identity placeholders, declaration of competing interests Word file, AI declaration text decision, funding text decision, EES account, cover letter, arXiv-first plan.
