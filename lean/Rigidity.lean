/-!
# Rigidity — top-level library

Re-exports every kernel module. Use this as the public entry point.

## Modules

- `Rigidity.Bracket`       — definitions + binary bracket (T-bracket, plus
                              D-prob, D-part, D-eps*, D-bphi, D-norm, D-tent, D-cphi).
- `Rigidity.Theorem1`      — refinement-monotone ⟺ concave (T1).
- `Rigidity.Theorem2`      — binary rigidity, `T` is the unique exact score (T2).
- `Rigidity.Theorem2Prime` — simplex rigidity (T2′; long-pole node).
- `Rigidity.Proposition6`  — two-query identity + variance bracket (P6).
- `Rigidity.WorkedExample` — §4.3 numerical verification via `decide` (W43).

See `14-harness_and_reproduction.md` for the brick-DAG and the provenance map
from each Lean target back to manuscript paragraphs and defining commits.
-/

import Rigidity.Bracket
import Rigidity.Theorem1
import Rigidity.Theorem2
import Rigidity.Theorem2Prime
import Rigidity.Proposition6
import Rigidity.WorkedExample
