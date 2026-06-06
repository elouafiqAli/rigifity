# Tutorial: Sierpiński's theorem and the `MeasuredSets`-IVT proof

*A walk-through of the proof formalized in [`Sierpinski.lean`](Sierpinski.lean). Written for a mathlib reviewer who wants the mathematics before the Lean — and for a would-be proof-completer who needs the exact obstruction we left as `sorry`.*

## §1. Statement and history

> **Theorem (Sierpiński 1922 / Sikorski 1958).** Let $(\Omega, \Sigma, \mu)$ be an *atomless* σ-finite measure space and let $t \in [0, \mu(\Omega)]$. Then there exists $S \in \Sigma$ with $\mu(S) = t$.

A measure $\mu$ is **atomless** if no measurable set $A$ satisfies $\mu(A) > 0$ and "$A$ is indivisible up to null" — formally, $\forall B \subseteq A \text{ measurable}, \mu(B) \in \{0, \mu(A)\}$. The classical statement appears under several names ("intermediate value theorem for measures", "Darboux property", "Sierpiński's theorem on non-atomic measures"); attribution is muddled because Sierpiński's 1922 paper proves a weaker form. Sikorski 1958 is the earliest fully-modern statement; Maharam 1942 gives a measure-algebra generalization.

The theorem appears as a Wikipedia "Atom (measure theory)" claim, in standard texts (Bogachev, Federer, Halmos), and is the engine behind most "measure-theoretic IVT" constructions in probability and ergodic theory. Yet **mathlib4 v4.29.1 does not carry it.** This PR fixes that gap.

## §2. The proof in pictures

The construction is iterative — like the standard proof of the IVT itself, but with sets in place of points.

### §2.1. Halving (the doubling lemma)

Start with $A \in \Sigma$, $0 < \mu(A) < \infty$. We claim:

> There exists measurable $B \subseteq A$ with $\mu(B) = \mu(A)/2$.

**Proof sketch.** Consider the metric space $(\operatorname{MeasuredSets}(\mu|_A), d)$ where $d(s,t) = \mu(s \triangle t)$ is the symmetric-difference distance. Gouëzel (added to mathlib in v4.29.1) proved that $\mu$ is *continuous* on this metric space — moving a set by a small symmetric difference moves the measure by a correspondingly small amount.

Now consider the path $\gamma : [0, 1] \to \operatorname{MeasuredSets}(\mu|_A)$ where $\gamma(s) \subseteq A$ is "the bottom-$s$-fraction of $A$" under any measurable enumeration (Borel-isomorphism to $[0, \mu(A)]$ works, but we will avoid invoking it explicitly by using `MeasuredSets`'s built-in countable-dense-subset structure). Then $\mu \circ \gamma : [0, 1] \to [0, \mu(A)]$ is continuous, $\mu(\gamma(0)) = 0$, and $\mu(\gamma(1)) = \mu(A)$. By the standard intermediate value theorem (`Continuous.surjOn_Icc` in mathlib), the image is the full interval — so $\mu(A)/2$ is attained.

The atomless hypothesis enters in proving continuity at one specific point: if $\mu(\{x\}) = 0$ for every singleton, the "path" cannot have jump discontinuities at endpoints of plateaus, which is exactly the condition for IVT to be informative.

### §2.2. Dyadic refinement

Iterating §2.1: halve $A$ into $B_0 \subset A$ with $\mu(B_0) = \mu(A)/2$. Halve $B_0$ into $B_{00}$, halve $A \setminus B_0$ into $B_1$. After $n$ rounds we have a dyadic partition $\{A_w : w \in \{0,1\}^n\}$ with each cell having measure $\mu(A) / 2^n$.

For any $t \in [0, \mu(A)]$ we can pick a sequence of "good" cells whose union has measure converging to $t$. The "right" sequence is the binary expansion of $t/\mu(A)$:
$$
t / \mu(A) = \sum_{n=1}^{\infty} \epsilon_n / 2^n, \quad \epsilon_n \in \{0,1\}.
$$
The witness $S$ is the union of cells $A_{\epsilon_1 \epsilon_2 \cdots \epsilon_n}$ along the binary expansion.

### §2.3. From finite to σ-finite

Given σ-finiteness, write $\Omega = \bigsqcup_n E_n$ with each $E_n$ measurable and $\mu(E_n) < \infty$. Set $T_n = \sum_{i < n} \mu(E_i)$. For target $t \le \mu(\Omega) = \sup_n T_n$, pick $n_0$ with $T_{n_0} \le t < T_{n_0+1}$ and the residual $r = t - T_{n_0} \in [0, \mu(E_{n_0}))$. Apply §2.2 inside $E_{n_0}$ to get $S_{n_0} \subseteq E_{n_0}$ with $\mu(S_{n_0}) = r$. The full realizer is $S = \bigsqcup_{i < n_0} E_i \cup S_{n_0}$.

Edge case: $t = \mu(\Omega)$ takes $S = \Omega$. Edge case: $t = 0$ takes $S = \emptyset$. Both handled trivially.

## §3. From math to Lean: where the work is

The Lean source [`Sierpinski.lean`](Sierpinski.lean) declares two theorems:

```lean
theorem exists_measurableSet_measure_eq_of_noAtoms
    [NoAtoms μ] [SigmaFinite μ] {t : ℝ≥0∞} (ht : t ≤ μ Set.univ) :
    ∃ s : Set α, MeasurableSet s ∧ μ s = t

theorem exists_measurableSet_toReal_measure_eq_of_noAtoms
    [NoAtoms μ] [IsFiniteMeasure μ] {t : ℝ} (h₀ : 0 ≤ t) (h₁ : t ≤ (μ Set.univ).toReal) :
    ∃ s : Set α, MeasurableSet s ∧ (μ s).toReal = t
```

and one private lemma:

```lean
private lemma exists_measurableSet_subset_measure_eq_half_of_noAtoms
    {A : Set α} (hA : MeasurableSet A) (hAfin : μ A < ⊤) (hApos : 0 < μ A) :
    ∃ B : Set α, MeasurableSet B ∧ B ⊆ A ∧ μ B = μ A / 2
```

The `.toReal` companion is **fully proved** in the file — it is a one-line bridge using `ENNReal.toReal_ofReal h₀` once the ℝ≥0∞ version is available.

The σ-finite reduction (§2.3) is **scripted as a comment block** in `exists_measurableSet_measure_eq_of_noAtoms` — the five steps are spelled out — but the body is `sorry`'d because the inductive accounting (`Tₙ`, picking `n₀`) is tedious-but-mechanical Lean (≈ 30–50 LoC) and was deferred to the proof-completion phase.

The doubling lemma `exists_measurableSet_subset_measure_eq_half_of_noAtoms` is **also `sorry`'d** with a detailed comment, because it is the *one non-trivial step* that depends on Gouëzel's `MeasuredSets.continuous_measure` (the precise API surface we need has not been confirmed against the live mathlib source — we cite it from the v4.29.1 file we know contains the metric structure, but the exact lemma name for "$\mu$ is continuous on `MeasuredSets`" may differ).

## §4. Filling in the `sorry`s — proof-completer's guide

This section is for the maintainer or contributor who picks up the PR after this folder and finishes it.

### §4.1. The doubling lemma — what to look up in mathlib

The doubling lemma needs:

1. **The metric structure on `MeasuredSets μ`**: in `Mathlib.MeasureTheory.Measure.MeasuredSets`, look for the `MetricSpace` (or `EMetricSpace`) instance and the `edist`-definition. The distance is $\mu(s \triangle t)$.
2. **Continuity of $\mu$**: look for a lemma named something like `MeasuredSets.continuous_measure` or `MeasureTheory.MeasuredSets.measure_continuous`. If it does not exist, prove it directly: $|\mu s - \mu t| \le \mu(s \triangle t)$ (one-line `Measure.tsub_measure_compl_le` argument).
3. **The "path" parameterization**: this is where the work is. Two options:
   - **Option A (mathlib-native).** Use the `Borel.standard` Borel-isomorphism for atomless σ-finite measures (Wikipedia: "Standard probability space"; the existence of this isomorphism is itself non-trivial in mathlib). If `α` is isomorphic to `([0, μ univ], Lebesgue)`, the path $\gamma(s) = [0, s \cdot \mu(A)]$ pulled back through the iso is exactly what we want.
   - **Option B (constructive).** Build the dyadic partition $\{A_w\}_{w \in 2^{<\omega}}$ inductively without invoking the Borel isomorphism — at each level, choose the halving witness from the IVT applied to a chained sequence. This is more self-contained but circular if we are trying to *prove* the doubling lemma.

   **Recommended:** Option A if mathlib v4.29.1 already has the Borel-iso result; Option B as a fallback that proves Sierpiński's theorem in its own terms (a dyadic refinement procedure indexed by the binary expansion of $t/\mu(A)$).

### §4.2. The σ-finite reduction — what's left

The five steps in the comment block of `exists_measurableSet_measure_eq_of_noAtoms` are:

1. Decompose along `SigmaFinite.spanningSets μ`. Mathlib calls these `MeasureTheory.spanningSets μ : ℕ → Set α`, with `measure_spanningSets_lt_top` and `iUnion_spanningSets` as the supporting lemmas.
2. Cumulants `Tₙ = ∑ᵢ<n μ Eᵢ` via `Finset.sum`.
3. Pick `n₀` with `T_{n₀} ≤ t < T_{n₀+1}` (or `n₀ = ⊤`). Handle the `⊤` case separately.
4. Apply the finite case (which uses the doubling lemma) inside `E_{n₀}`.
5. Assemble and verify additivity (`MeasureTheory.measure_iUnion` for the countable-disjoint case).

This is ≈ 30–50 LoC and should be straightforward once §4.1 is done. The hardest detail is handling the `t = μ univ` boundary correctly when `μ univ = ⊤` (the `[SigmaFinite μ]` allows `μ univ = ⊤`; the theorem reduces to "every value below `⊤` is attained" plus "`⊤` is attained by `Set.univ`").

### §4.3. Style checklist

The skeleton in `Sierpinski.lean` is already mathlib-styled, but the proof-completer should re-check:

- [ ] Docstrings: first sentence is a complete sentence (no period unless it's two sentences), bold theorem name on first occurrence (`**Sierpiński's theorem**`).
- [ ] Variable naming: `t` for the target, `s` for the witness, `A`/`B` for working sets, `μ` for the measure. Avoid Greek capital letters in `let`-bindings.
- [ ] `simp [...]`: avoid simp-only collections unless they fail to discharge — mathlib prefers `simp` with explicit lemmas in the discharge spec.
- [ ] `omega` and `decide`: avoid in measure-theory proofs; use `linarith`, `positivity`, `gcongr` where appropriate.
- [ ] `Mathlib/Tactic/...`: do not invent new tactic dependencies; reuse what `NoAtoms.lean` already imports.

### §4.4. Test plan

Once `sorry`s are filled in:

1. Compile against current mathlib `master` (not just v4.29.1).
2. Add three regression tests to `MathlibTest/MeasureTheory/NoAtomsRealizability.lean`:
   - Lebesgue on `[0, 1]`: realize `t = 1/3` and confirm `S = [0, 1/3]` (up to null).
   - Lebesgue on `ℝ`: realize `t = 5` and `t = ⊤`.
   - An atomless probability on `ℕ × [0,1]`: confirm σ-finite path works.
3. Run `lake exe shake` to ensure no extra imports leaked in.
4. Run `lake exe runLinter` — expect `docPrime` flags on the theorem names; suppress with the `unusedHavesSuffices` linter exception only if necessary.

## §5. Why this proof and not Zorn's lemma

The standard textbook proof uses Zorn's lemma on the partially-ordered set $\{(t, S) : \mu(S) = t \le t_0\}$ ordered by extension, and pulls out a maximal element. This works without σ-finiteness but is **harder to formalize in mathlib** because:

1. Zorn's lemma in mathlib (`zorn_partialOrder`) wants the underlying type, not a subset — extracting the maximal-set witness requires explicit choice manipulation.
2. The "extension" relation needs careful Setoid handling (sets equal almost-everywhere are equivalent).
3. The argument is non-constructive in a way that makes it impossible to extract a computable realizer — even in the Lebesgue-on-`[0,1]` case where there is a perfectly explicit one.

The IVT-on-`MeasuredSets` route is constructive (modulo the Borel isomorphism, which is non-constructive but used as a black box), 60–80 LoC instead of 300–500, and aligns mathlib's `NoAtoms` API with its existing `MeasuredSets`/`Topology.IntermediateValue` infrastructure.

The σ-finite restriction is a real loss — the general statement does need Zorn — but covers every measure of practical interest (every probability measure, every Lebesgue / Hausdorff / Haar measure on a second-countable space, every Borel measure on a Polish space). The follow-up PR can add the Zorn-route extension to non-σ-finite measures.

## §6. References (extended)

- Sierpiński, W. *Sur les fonctions d'ensemble additives et continues*, Fund. Math. **3** (1922), 240–246.
- Sikorski, R. *On a generalization of theorems of Banach and Cantor–Bernstein*, Colloq. Math. **1** (1948), 140–144.
- Maharam, D. *On homogeneous measure algebras*, Proc. Nat. Acad. Sci. USA **28** (1942), 108–111.
- Bogachev, V. I. *Measure Theory*, Vol. I, Springer 2007, §1.12.
- Halmos, P. R. *Measure Theory*, Van Nostrand 1950, §41 (the relevant "atom" theorem).
- Carlen, E. *Notes on divisibility of non-atomic measures*, Rutgers 501F10 lecture notes (2010). PDF: `https://sites.math.rutgers.edu/~carlen/501F10/atomic.pdf`.
- MathOverflow 222583, *A result of Sierpiński on non-atomic measures*. https://mathoverflow.net/questions/222583.
- Math.SE 3919475, *Atoms in a measure space and Sierpinski theorem*. https://math.stackexchange.com/questions/3919475.
- Math.SE 1606451, *Property of atomless probability measures*. https://math.stackexchange.com/questions/1606451.
- Wikipedia, *Atom (measure theory)*. https://en.wikipedia.org/wiki/Atom_(measure_theory).
- Lyapunov-style generalization: *Lyapunov's theorem on vector measures*, arXiv:2411.16651.
