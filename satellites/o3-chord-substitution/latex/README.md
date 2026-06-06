# LaTeX harness — satellite O3 (CRAS submission)

*Phase I deliverable per [`../06-cras-strategy.md`](../06-cras-strategy.md) §3 Phase I. Sources the English manuscript ([`../09-draft0.3-manuscript.md`](../09-draft0.3-manuscript.md)) and the French manuscript ([`../13-draft0.4-fr-manuscrit.md`](../13-draft0.4-fr-manuscrit.md)) and ships them as a ready-to-compile CRAS-Mathématique submission package.*

---

## Files

| File | Purpose |
|---|---|
| [`chord-substitution-en.tex`](chord-substitution-en.tex) | English manuscript LaTeX source |
| [`chord-substitution-fr.tex`](chord-substitution-fr.tex) | French manuscript LaTeX source |
| [`refs.bib`](refs.bib) | Shared BibTeX bibliography (alphabetical by first-author surname per CR Mathématique convention) |
| [`build.ps1`](build.ps1) | Windows PowerShell build harness |
| [`build.sh`](build.sh) | POSIX (Linux/macOS/WSL) build harness |
| [`.gitignore`](.gitignore) | Excludes LaTeX build artifacts from version control |

---

## Quick start

### Windows (PowerShell)

```powershell
# From this directory (satellites/o3-chord-substitution/latex/):
./build.ps1                  # builds both en and fr manuscripts
./build.ps1 -EnOnly          # English only
./build.ps1 -FrOnly          # French only
./build.ps1 -Clean           # remove all artifacts (.aux, .bbl, .pdf, ...)
```

### Linux / macOS / WSL (POSIX bash)

```bash
chmod +x build.sh
./build.sh                   # builds both en and fr manuscripts
./build.sh --en-only         # English only
./build.sh --fr-only         # French only
./build.sh --clean           # remove all artifacts
```

### Manual (without the harness)

```bash
pdflatex chord-substitution-en
bibtex   chord-substitution-en
pdflatex chord-substitution-en
pdflatex chord-substitution-en
# Repeat for chord-substitution-fr
```

The harness adds: toolchain validation, clean failure reporting, and a summary table showing PASS/FAIL + page count + word count for each manuscript.

---

## Toolchain requirements

| Tool | Purpose | Install |
|---|---|---|
| `pdflatex` | LaTeX→PDF compilation | MiKTeX (Windows), TeX Live (Linux), MacTeX (macOS) |
| `bibtex` | Bibliography processing | (bundled with the above) |
| `pdfinfo` | (optional) PDF page count for the summary | (bundled with poppler-utils on Linux; with MiKTeX/MacTeX on Windows/macOS) |

**Minimum LaTeX packages used** (all standard in MiKTeX / TeX Live "full" install):
- `amsart` (article class)
- `amssymb`, `amsmath`, `amsthm` (math)
- `babel` with `[french]` and `[english]` options
- `csquotes` (French guillemets «»)
- `booktabs`, `array`, `tabularx` (Table 1 layout)
- `lineno` (numbered lines for submission)
- `microtype`, `hyperref`, `geometry`
- `inputenc[utf8]`, `fontenc[T1]`

---

## CRAS-Mathématique class file (`crmath`)

CRAS Mathématique **mandates** submission with the official Centre Mersenne class. The class file is bundled in `pack_author-crmath.zip` at:

→ <https://www.centre-mersenne.org/media/texmf/pack_author-crmath.zip>

### Installation (CRAS-official mode)

1. **Download** `pack_author-crmath.zip` from the URL above.
2. **Unzip** it; you'll find `crmath.cls`, sample BibTeX styles, and a sample document.
3. **Install the class** — two options:
   - **Local (recommended):** copy `crmath.cls` and any associated `.bst` files into this directory (alongside the `.tex` files). Both English and French manuscripts will pick it up automatically when you edit the class line in each `.tex` file.
   - **System-wide:** place the class file in your TeX installation's local texmf tree. On TeX Live: `~/texmf/tex/latex/crmath/crmath.cls`. On MiKTeX: use the package manager or place under `localtexmf/tex/latex/crmath/`. Run `mktexlsr` (TeX Live) or "Refresh FNDB" (MiKTeX Console) to register the new class.
4. **Switch each `.tex` file to use the official class** — at the top of both `chord-substitution-en.tex` and `chord-substitution-fr.tex`, locate:

   ```latex
   % --- OFFICIAL CRAS CLASS (preferred) ---
   % \documentclass{crmath}

   % --- FALLBACK AMSART CONFIGURATION (active by default) ---
   \documentclass[11pt,a4paper]{amsart}
   ```

   Comment out the `amsart` block and uncomment `\documentclass{crmath}`. (The `crmath` class brings its own theorem environments, font, geometry; the helper preamble below is redundant in the official build and can be left in or pruned per the official template's expectations — verify against the sample document in `pack_author-crmath.zip`.)

5. **Switch the BibTeX style** from `plain` to the `crmath` style if one is provided in the zip (the alphabetical-by-first-author convention is handled automatically). At the bottom of both `.tex` files, locate:

   ```latex
   \bibliographystyle{plain} % FALLBACK
   \bibliography{refs}
   ```

   Replace `plain` with the `crmath` style name as named in the official package (typically `crmath` or `cedram-style`).

6. **Rebuild** with `./build.ps1` (Windows) or `./build.sh` (POSIX). The output PDF should now carry the Centre Mersenne page geometry and CR Mathématique header.

### Fallback mode (what's active by default)

The `.tex` files ship with `amsart` active so that the manuscripts compile *now* on any LaTeX installation, without requiring the user to first download the Centre Mersenne package. This is the right mode for:
- **Drafting and revision** — read the PDF locally before fetching the official template.
- **Cross-platform verification** — confirms the LaTeX is correct independently of the CRAS package.
- **CI / harness** — the build script's PASS/FAIL gate works with the fallback.

The fallback honors CRAS-Mathématique requirements (Roman top-level sections, A4, double-spaced submission version, numbered lines, French theorem environments in the French manuscript) so the rendered PDFs are visually close to the final CRAS-typeset version. Switch to the official class before OJS dispatch.

---

## Output

After a successful run the directory contains:

```
chord-substitution-en.pdf    # English manuscript (PDF, ~5 pages)
chord-substitution-fr.pdf    # French manuscript (PDF, ~5 pages)
chord-substitution-en.bbl    # processed bibliography (en)
chord-substitution-fr.bbl    # processed bibliography (fr)
+ various .aux, .log, .out artifacts
```

Both `.pdf` files are the submission-ready compiled manuscripts. The `.bbl` files contain the processed bibliography (CRAS requires the `.bib` file at submission *and* the manuscript references resolved via the `.bbl`).

---

## Submission package contents (per CRAS instructions, gate G-5)

At OJS dispatch, the submission must include:

1. **TeX source(s):**
   - `chord-substitution-en.tex` (for English-primary submission), OR
   - `chord-substitution-fr.tex` (for French-primary submission), OR
   - both (we recommend submitting one as primary and the other as supplementary translation per CRAS guidelines)
2. **Compiled PDF(s):** `chord-substitution-en.pdf` and/or `chord-substitution-fr.pdf`
3. **BibTeX file:** `refs.bib`
4. **(Optional) class and style files:** if you've installed `crmath.cls` and a custom `.bst`, you may attach them too. The CRAS team uses the Centre Mersenne package on their side, so they will *not* be inserted into the published version, but attaching them ensures the editor can reproduce your compile.

Per the format reconnaissance in [`../07-cras-format-reconnaissance.md`](../07-cras-format-reconnaissance.md) §2 G-5: *"All submissions in TeX format must include at least three elements: the full text of the article in TeX format (source file); the full text of the article in PDF format (compiled file); the article's bibliography in BIB format. Any submission that does not include these elements may be rejected without evaluation."*

---

## Pre-flight checks before OJS dispatch

Run `./build.ps1` (or `./build.sh`) and verify:

- [ ] `HARNESS: PASS` reported
- [ ] Both `chord-substitution-en.pdf` and `chord-substitution-fr.pdf` exist
- [ ] Page count for each is ~4–6 pages (CRAS short-note expectation)
- [ ] Word count for each is ~1700–2500 words (the body, excluding bibliography)
- [ ] No undefined references warnings in the build logs (`*.log`, `*.blg`)
- [ ] No `[AUTHOR]` placeholder remaining (find via `grep -n AUTHOR *.tex`)
- [ ] No `[INSTITUTION` placeholder remaining (find via `grep -n INSTITUTION *.tex`)
- [ ] `[El1]`, `[El2]` BibTeX entries have an actual author surname or are clearly placeholder-marked

The [`../99-submission-checklist.md`](../99-submission-checklist.md) (Phase J) walks through the full submission-day procedure including the affiliation gate G-1 and the bilingual-metadata gate G-4.

---

## Troubleshooting

### "File `crmath.cls' not found"
You haven't installed the Centre Mersenne package yet. Either follow the install steps above or leave the file in fallback mode (default).

### `babel` complains about French
On some MiKTeX installs the French language module needs explicit installation:
```bash
# MiKTeX (Windows)
mpm --install=babel-french

# TeX Live (Linux/macOS)
tlmgr install babel-french
```

### "Undefined control sequence \og" or similar `babel[french]`-related error
You likely need the `csquotes` package or the `babel-french` language module. Both are listed in the toolchain table above; install as needed.

### `bibtex` reports "I couldn't open style file plain.bst" or similar
The TeX installation is missing standard styles. Run a package update:
- MiKTeX: open MiKTeX Console → Updates → Check for updates.
- TeX Live: `tlmgr update --all`.

### The PDF looks wrong (font, margins)
You're probably in fallback mode (amsart). This is expected — the fallback is *close* to CRAS-style but not pixel-perfect. Install the `crmath` class to get the official layout.

### Build script: "the term `Get-Command' is not recognized"
You are running an old PowerShell version. Upgrade to PowerShell 7+ (`pwsh`) or use the POSIX `build.sh` instead.

---

## Hand-off to Phase J

The LaTeX harness is the last engineering deliverable before submission. The next phase ([`../99-submission-checklist.md`](../99-submission-checklist.md)) is the operational pre-flight: OJS account, affiliation gate, cover letter, arXiv-first deposit, reviewer suggestions. See [`../06-cras-strategy.md`](../06-cras-strategy.md) §3 Phase J for the full checklist.
