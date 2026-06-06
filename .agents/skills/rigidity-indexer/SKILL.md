---
name: rigidity-indexer
description: Use when searching the `.samples/` Lean blueprint reference archive for "how did project X structure their lakefile / theorem statement / CI workflow / blueprint LaTeX" without grepping 5,500+ files. Covers the tree-sitter + ChromaDB index, CLI, query patterns, filtering, programmatic access, and re-index workflow.
---

# Rigidity Indexer — RAG over `.samples/`

`.indexer/` is a local-only Python tool that builds a structure-aware
semantic index over every Lean blueprint reference project shallow-cloned
into `.samples/`. The index lets you ask natural-language questions about
the 27+ reference projects and get back the right theorem, blueprint
section, or config file in sub-second time.

Use this skill whenever you need to look up patterns from prior blueprint
projects (lakefile flags, blueprint LaTeX conventions, CI workflows, Lean
tactic structuring on long proofs, etc.) before greppping by hand.

## Index at a glance

| Property | Value |
|---|---|
| Storage | ChromaDB persistent client at `.indexer/chroma/` |
| Embeddings | `BAAI/bge-small-en-v1.5` (384-dim, L2-normalized, cosine) |
| Chunkers | tree-sitter `lean` / `latex` / `markdown` + regex fallback + char-window |
| Total chunks | ~65 k (across ~5.5 k files, ~27 projects) |
| Per-chunk metadata | `relpath, ext, file_sha1, chunk_index, start_line, end_line, kind, name, extra_json` |
| Re-index | incremental via `file_sha1`; unchanged files skipped |

## Entry point

Single PowerShell wrapper. No need to activate the venv manually.

```powershell
.\.indexer\tools.ps1 setup                                 # one-time: uv venv + deps
.\.indexer\tools.ps1 index                                 # incremental (skip unchanged file_sha1)
.\.indexer\tools.ps1 index --clear                         # wipe + rebuild
.\.indexer\tools.ps1 index --root pfr --limit 5            # smoke test one project
.\.indexer\tools.ps1 stats                                 # collection breakdown
.\.indexer\tools.ps1 query "<text>" -k 8 [--ext .lean] [--kind lean.theorem] [--project pfr]
.\.indexer\tools.ps1 clear --yes                           # drop collection
```

## Chunk taxonomy

Each chunk carries a `kind` and (where extractable) a `name`. Filter on
both to cut noise.

| Source | `kind` values | `name` field |
|---|---|---|
| Lean | `lean.theorem`, `lean.lemma`, `lean.def`, `lean.instance`, `lean.structure`, `lean.inductive`, `lean.class`, `lean.axiom`, `lean.example`, `lean.abbrev`, `lean.preamble`, `lean.decl`; `+gen` suffix when re-split | declaration identifier |
| LaTeX | `tex.theorem`, `tex.lemma`, `tex.definition`, `tex.proposition`, `tex.corollary`, `tex.remark`, `tex.section`, `tex.subsection`, ... | `\label{...}` or section title |
| Markdown | `md.h1` … `md.h6`, `md.preamble`; `+gen` when re-split | heading text |
| Other | `generic` | (empty) |

LaTeX chunks also encode `\lean{...}` and `\uses{...}` blueprint refs in
`extra_json` (JSON-encoded — Chroma metadata must be scalar).

## Query recipes

### Find a theorem statement by concept

```powershell
.\.indexer\tools.ps1 query "polynomial Freiman Ruzsa" -k 5 --project pfr --kind lean.theorem
.\.indexer\tools.ps1 query "entropy compression lemma" -k 5 --kind lean.lemma
.\.indexer\tools.ps1 query "Behrend sum-free large set" -k 5 --ext .lean
```

### Find a blueprint LaTeX example

```powershell
.\.indexer\tools.ps1 query "uses lean dependency graph" -k 5 --ext .tex
.\.indexer\tools.ps1 query "definition dyadic interval" --kind tex.definition
```

### Find a lakefile / CI pattern

```powershell
.\.indexer\tools.ps1 query "lakefile lean options warn sorry" -k 8 --ext .toml
.\.indexer\tools.ps1 query "github actions blueprint deploy" --ext .yml
```

### Find a markdown convention from AGENTS.md / CONTRIBUTING.md

```powershell
.\.indexer\tools.ps1 query "agent convention naming module" --ext .md
.\.indexer\tools.ps1 query "blueprint statement and proof split" --ext .md
```

## Filter semantics

* `--ext` and `--kind` map to a Chroma `where` clause; **both can compose** (AND).
* `--project NAME` is a **post-filter on `relpath`** (Chroma `where` has no
  `$contains`). The CLI overfetches `k * 3` then trims to `k` after filtering.
* Distance metric is cosine; the displayed `score` is `1 - distance`. Above
  0.80 is usually a direct hit; 0.70–0.80 is conceptually related; below
  0.70 is weak — try a more specific query or a `kind` filter.

## Programmatic access

```python
from pathlib import Path
from indexer.config import Config
from indexer.embed import Embedder
from indexer.store import Store

cfg = Config.load(Path(".indexer/config.yaml"), Path("."))
store = Store(cfg.chroma, cfg.chroma_abspath())
embed = Embedder(cfg.embedding)

vec = embed.encode_query("Plünnecke–Ruzsa inequality")
res = store.query(vec, k=10, where={"kind": "lean.theorem"})
for doc, meta, dist in zip(
    res["documents"][0], res["metadatas"][0], res["distances"][0]
):
    print(f"{1-dist:.3f}  {meta['relpath']}#L{meta['start_line']}  {meta['name']}")
```

Run from the workspace root with the indexer venv:
```powershell
& .indexer\.venv\Scripts\python.exe -c "<above>"
```

## Maintenance

### After cloning new sample projects

```powershell
.\.indexer\tools.ps1 index           # incremental — only new files embedded
```

### After config change (chunk sizes, model)

```powershell
.\.indexer\tools.ps1 index --clear   # full rebuild; model swap requires this
```

### After editing chunker logic

Force re-embed of changed files (file_sha1 won't have changed, so
incremental skips them):
```powershell
.\.indexer\tools.ps1 index --reindex
```

### Inspect a single project

```powershell
.\.indexer\tools.ps1 index --clear --root <project>
.\.indexer\tools.ps1 stats
```

## Adding extensions / paths

Edit [`config.yaml`](../../../.indexer/config.yaml):

```yaml
roots:
  - .samples
  - .research        # uncomment to index our notes
extensions:
  - .lean
  - .tex
  # add a new one here
exclude_path_fragments:
  - "/.lake/"
  - "/.git/"
  # add more here
```

Then `tools.ps1 index --reindex` to pick up files matching the new
extension that were previously ignored.

## Gotchas

* **Don't put the index on NTFS through WSL.** Chroma is fine on Windows
  NTFS native; keep it under `.indexer/chroma/`.
* **Chroma SQLite limit ~999 placeholders per query.** Page `get()` calls
  in batches of ≤500. (Already done in `cli.py stats` and
  `store.file_signatures`.)
* **PowerShell `$Args` collision.** `tools.ps1` uses `$Extras` for the
  forwarded args. Don't rename to `$Args` — PowerShell's automatic variable
  shadows the parameter and silently drops everything.
* **`chromadb.PersistentClient` defaults to its own embedding function.**
  We pass `embedding_function=None` on `get_or_create_collection` so our
  precomputed vectors aren't silently re-embedded. Don't remove this.
* **Score interpretation:** displayed `score = 1 - cosine_distance`, so
  range is roughly [0, 1] for normalized embeddings. ≥ 0.80 strong hit;
  ≥ 0.70 related; < 0.70 weak.
* **`--project` is a post-filter.** It overfetches `k * 3`. For large
  collections you may want to raise that ratio if a project has very few
  chunks.
* **First query is slow (~5–10 s)** because sentence-transformers loads
  the model into memory. Subsequent queries in the same process are < 1 s.

## When NOT to use this skill

* For exact-string code search use `grep_search` — semantic search blurs
  identifiers.
* For Lean LSP type/goal lookup, use the `mcp_lean_lsp_*` tools, not this
  index. The index is for cross-project conceptual lookup, not live
  language-server queries.
* For querying our own Lean source under `lean/`, use Lean LSP / outline
  tools. This index targets the read-only `.samples/` archive.

## File layout

```
.indexer/
├─ pyproject.toml, config.yaml, tools.ps1, README.md, .gitignore
├─ .venv/, chroma/                              # NOT tracked
└─ src/indexer/
   ├─ cli.py            # click CLI (index/query/stats/clear)
   ├─ config.py         # YAML → frozen dataclasses
   ├─ walk.py           # filesystem traversal + excludes
   ├─ embed.py          # sentence-transformers wrapper
   ├─ store.py          # chromadb wrapper
   └─ chunkers/
      ├─ _types.py      # Chunk dataclass
      ├─ _ts.py         # tree-sitter helper (lazy parser load)
      ├─ generic.py     # char-window with overlap
      ├─ lean.py        # Lean 4 grammar + regex fallback
      ├─ latex.py       # LaTeX grammar + regex fallback
      └─ markdown.py    # Markdown grammar + regex fallback
```

See [`.indexer/README.md`](../../../.indexer/README.md) for full setup
instructions and config reference.
