# Round 0 — Extraction, context, and pre-flight check

*Satellite O3, [`../../21-publication_plan.md`](../../21-publication_plan.md) §4.1. Construct C4. Authored 2026-06-06 by Executor T.*

---

## 1. What we are extracting

A single mathematical fact, plus the dictionary of regularity hypotheses it does *not* need.

**The fact.** Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy
$$pG(u_1)+(1-p)G(u_2) \;=\; G\!\bigl(pu_1+(1-p)u_2\bigr) \qquad \text{for all } u_1,u_2\in[0,M],\ p\in[0,1]. \tag{$\star$}$$
Then $G$ is affine on $[0,M]$: $G(v)=av+b$ with $a=(G(M)-G(0))/M$ and $b=G(0)$. The proof is a one-line substitution that pins $G$ along the chord through the endpoints.

**The dictionary.** Three regularity hypotheses are commonly invoked when this equation appears in applied work:

1. *Continuity of $G$.* Not needed.
2. *Boundedness of $G$ on $[0,M]$.* Not needed.
3. *Measurability of $G$.* Not needed.

All three are vestigial — historical artefacts of the *discrete-coefficient* Jensen equation, where they are genuinely required to rule out Hamel-basis pathologies. The continuous-coefficient form $(\star)$ collapses under one substitution; the pathologies have nowhere to live.

---

## 2. The trigger — why this satellite is being written now

The construct surfaced as a defect-then-correction in the main paper:

- **Round-5 π audit** ([`../../07-pi_adversarial_audit_of_04.md`](../../07-pi_adversarial_audit_of_04.md) line 42) flagged the Step-2 proof: *"the functional equation … admits pathological (non-affine measurable) solutions if $G$ is unbounded — the standard Hamel-basis caveat. Here $G$ is bounded (image $\subseteq [0,1-1/k]$) so the bounded-Jensen-implies-affine theorem applies, but the argument should say so for a careful referee."*
- **Phase D mechanization** (Lean kernel) attempted the standalone lemma `affine_of_jensen_eq` with a boundedness hypothesis in the signature, then discovered the hypothesis was unused: the chord substitution closes the proof without invoking boundedness. The signature kept the hypothesis for documentation; the proof body marked it `_h_bdd` (see [`../../lean/Rigidity/Theorem2Prime.lean`](../../lean/Rigidity/Theorem2Prime.lean) lines 305–340).
- **Round-7 π audit** ([`../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md) line 48) recorded the surprise: *"the chord-trick Step 2 actually proves the claim cleanly (and reveals that the paper's classical 'no-Hamel-basis-pathology' worry was over-engineered — the continuous convex-combination form of Jensen's equation doesn't need boundedness)."*
- **Panel verdict M-2** ([`../../19-panel_verdict.md`](../../19-panel_verdict.md) §2) crystallised the disposition: *"rewrite §4.2 Step 2 to lead with the chord argument (pin one cell at a vertex, one at the φ-argmax), matching the kernel; if the boundedness remark is retained, mark it 'not required; included only for readers worried about Hamel pathologies.'"*

The main paper's §4.2 Step 2 has since been rewritten to lead with the chord argument ([`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) lines 160–166). What remains is to give the chord substitution a **standalone, citable home** so that the main paper can carry one inline reference rather than an inline proof + a parenthetical retraction of the Hamel detour.

This is the **standard ontological-seeding move**: the construct exists in the main paper, but it lives there as a tool buried inside a larger proof, where its standalone elegance is hidden by the GNN-calibration apparatus around it. Lifting it out lets the construct become *vocabulary* in the analysis curriculum — the half-page note that the next author who encounters the equation does not have to re-derive.

---

## 3. Five-question pre-flight check (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.3)

### Q1. Does this construct stand alone, or does it implicitly rely on a downstream result the small piece cannot cite?

**Stands alone.** The chord substitution is a self-contained fact about the functional equation $(\star)$ on a real interval. It has no dependency on the bracket, the resolution-axis transposition, the GNN-calibration framework, or anything else from the main paper. A reader who has *only* the satellite gets full mathematical value.

The forward references the satellite contains — "where this trap recurs" examples — are illustrative, not load-bearing. The theorem and its proof are independent.

### Q2. What is the one sentence the main paper will be able to write because this exists?

> "By [Author, CRAS 2026, Lemma 1], the functional equation $(\star)$ forces $G$ affine without measurability, boundedness, or continuity hypotheses; the explicit form is $G(v)=v\bigl(G(\varphi_{\max})-G(0)\bigr)/\varphi_{\max}+G(0)$, obtained by setting $u_1=\varphi_{\max}$, $u_2=0$, $p=v/\varphi_{\max}$."

That is *the* sentence. It replaces the current ~6-line Step-2 prose in §4.2 of the main paper (including the parenthetical that retracts the Hamel concern). The satellite produces a 5:1 compression of the main paper's prose at the load-bearing step, by exporting the proof to a refereed pointer.

### Q3. Who is the hostile referee for this piece, and what is their veto?

**Primary hostile referee: Judge π** (internal devil's advocate). Veto criteria:

- *V-π1.* "This is trivial / well-known to specialists." The piece must defend its claim to expository value by **(a)** documenting the recurrence of the trap (at minimum: the present author's own earlier drafts), **(b)** showing that the standard references (Aczél, Kuczma) bury the observation in a chapter on functional equations rather than packaging it as a one-line teaching note, and **(c)** earning its citation utility by being shorter, clearer, and more cite-able than the existing references.
- *V-π2.* "The dictionary is wrong / over-claims." The three "not needed" hypotheses (continuity, boundedness, measurability) must each be *separately* shown to be unnecessary, with the corresponding pathology that *would* apply if the equation were of discrete-coefficient type. Hand-waving the dictionary kills the paper.
- *V-π3.* "The framing misrepresents Aczél/Kuczma." If the standard references already contain the observation in essentially this form, the piece must say so explicitly. Concealing prior art is fatal.

**Secondary referee: Judge S** (statistics-side). Veto criteria:

- *V-S1.* "The recurrence claim is unsupported." The "where the trap recurs" section must cite at least one published instance from the broader statistics/calibration literature, not only the present author's own drafts. (If only the author's drafts are available, the framing must be carefully scoped to "in our own development" without over-claiming community-wide recurrence.)
- *V-S2.* "Reid–Williamson, BJM, Tewari–Bartlett, etc. don't have this problem, so the relevance to calibration theory is overstated." The piece must acknowledge which calibration-theory papers *do* run into the equation and which do not, and why.

### Q4. What is the closest existing precedent in the literature, and how does this piece position against it?

**Closest precedent.** Aczél, *Lectures on Functional Equations and Their Applications* (1966), Section 2.1, contains the continuous Jensen equation and observes that with the *continuum* of $p$-values the equation forces affineness. Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities* (2nd ed., 2009), Chapter 13, treats the discrete and continuous cases side-by-side. Both are encyclopaedic; neither is a one-page teaching note.

**Positioning.** The present note adopts the role *Comptes Rendus Mathématique* notes are designed for: a short, citable, self-contained pointer that articulates a specific point of confusion clearly enough that authors who encounter $(\star)$ in their own work have a one-line reference. The intellectual content is folklore; the **packaging** is the contribution. Precedent for this packaging — CRAS notes that articulate "well-known but recurrently confused" facts — is long-established (Cartan, Bourbaki, Tao have all published in this mode).

**Differentiation.** Two specific things this note does that Aczél and Kuczma do not:

1. The **dictionary** — an explicit side-by-side of which regularity hypothesis is required for which equation, packaged as a compact table.
2. The **calibration-theory positioning** — a documented site where the trap recurs in modern applied work, and a one-line citation a calibration-theory author can use to retire the Hamel concern.

### Q5. If rejected by the primary venue, what is the fallback venue, and what is the arXiv-first plan?

**Primary:** *Comptes Rendus Mathématique* (Académie des sciences, hosted on Elsevier). Bilingual French/English accepted; English here. Estimated review time 2–4 months.

**Fallback 1:** *Expositiones Mathematicae* (Elsevier). Slightly longer turnaround (~3–6 months) but explicitly accepts expository notes of this kind.

**Fallback 2:** *Mathematical Intelligencer* (Springer). More popular tone; would need a rewrite to broaden the on-ramp, but acceptable.

**Defer fallback:** *American Mathematical Monthly* / *Math. Mag.* / *College Math Journal* (MAA). Slow (6–12 months) — only as a last resort.

**arXiv-first plan.** Deposit on arXiv (`math.HO` History and Overview, cross-listed `math.CA` Classical Analysis and ODEs, cross-listed `math.FA` Functional Analysis) at the moment of submission to CRAS. The arXiv version carries a footnote *"submitted to Comptes Rendus Mathématique."* If CRAS accepts, the arXiv version is replaced with the accepted version; if CRAS declines, the arXiv version is the citable pointer until re-submission to a fallback. The main paper's bibliography references the arXiv ID, replaced with the CRAS DOI on acceptance.

---

## 4. Scoping decisions

### What is in

- The theorem, stated in its cleanest form ($I=[0,M]$, the equation for all $u_1,u_2\in I$ and $p\in[0,1]$).
- The one-line proof, complete with the explicit affine formula.
- The **dictionary** of three regularity hypotheses, each separately treated.
- A short history of why the Cauchy-equation worry attached to the equation — Cauchy (1821), Hamel (1905), Sierpiński (1920), Steinhaus (1920) — and why none of those concerns applies to $(\star)$.
- A "**weaker hypothesis**" remark: actually only the equation at $u_1=M$, $u_2=0$, free $p$ is used by the proof — useful for the reader who wants to know how much of $(\star)$ is being consumed.
- A "**higher dimensions**" remark: the same chord substitution applied to every line segment of a convex domain gives affineness on the whole convex set.
- A "**where the trap recurs**" subsection — at minimum the present author's own earlier drafts, with an explicit invitation to other authors to extend the list.

### What is out

- **No general theory of functional equations.** This is not a chapter; it is a one-line proof note. Kuczma owns the general theory.
- **No claim of priority.** The result is folklore. The note's contribution is expository.
- **No GNN content.** Not a word about graph neural networks, Bayes risk, partitions, or the main paper's apparatus. The note is pure real analysis.
- **No connection to the resolution-axis transposition or the bracket.** Those are downstream applications; the note must stand on its own as analysis.
- **No higher-dimensional generalization beyond a one-paragraph remark.** Convex-set domains can carry a full paper of their own (cf. convex analysis); not this paper.
- **No measure-theoretic re-derivation.** The setup is intentionally elementary so a senior undergraduate can read it.

---

## 5. Risks and mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| "Aczél §2.1 has this already." | high (this is the canonical reference) | cite Aczél prominently, position the note as the *teaching* / *citation-utility* contribution rather than as a novelty claim; quote the relevant Aczél text and articulate what this note adds (the dictionary + the recurrence documentation + the standalone CRAS-style citation point) |
| "This is trivial." | high | embrace it — the note's point is that a fact treated as deep is actually one line; the recurrence-in-applied-work documentation justifies the publication |
| CRAS rejects on novelty grounds | moderate | fallback to *Expositiones Mathematicae* (which explicitly accepts expository notes) |
| Citation list under-cites the functional-equations community | moderate | Judge S audit pass on prior art (Round 4) |
| Over-claim that the trap is widespread | moderate | scope claims tightly to documented cases (one's own drafts) and invite others to extend the catalog |

---

## 6. Cross-references

| Resource | Role in this satellite |
|---|---|
| [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) §4.2 lines 152–166 | Source of the result in context (the simplex rigidity Step 2) |
| [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) Appendix B.6 (~line 650) | The author's own confession of the over-engineered Hamel detour |
| [`../../lean/Rigidity/Theorem2Prime.lean`](../../lean/Rigidity/Theorem2Prime.lean) lines 305–340 | The Lean mechanization of the chord substitution (`affine_of_jensen_eq`) |
| [`../../lean/Rigidity/Theorem2Prime.lean`](../../lean/Rigidity/Theorem2Prime.lean) lines 592–674 | The inline use of the chord substitution in `simplex_rigidity` (`h_pin_vertex`) |
| [`../../07-pi_adversarial_audit_of_04.md`](../../07-pi_adversarial_audit_of_04.md) line 42 | Round-5 π audit that originally flagged the boundedness worry |
| [`../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md) line 48 | Round-7 π audit that recorded the surprise: boundedness was unused |
| [`../../19-panel_verdict.md`](../../19-panel_verdict.md) M-2 | Panel verdict that crystallised the rewrite + the satellite extraction |
| [`../../21-publication_plan.md`](../../21-publication_plan.md) §4.1 / O3 | The publication-plan entry that scopes this satellite |

---

## 7. Hand-off to Round 1

Executor T's task in Round 1: produce a ~4–6 page CRAS-format manuscript ([`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md)) covering, in order:

1. **Title + author + abstract** (4–6 line CRAS abstract).
2. **§1 Introduction** — the equation, the historical Cauchy/Hamel context, the punchline (one-line proof closes it).
3. **§2 The result and its proof** — Theorem 1 + one-line proof + explicit affine formula.
4. **§3 The dictionary** — three regularity hypotheses, each separately treated, with the corresponding pathology for the *discrete*-coefficient equation that fails to arise here.
5. **§4 Variants and limits** — weaker-hypothesis remark, higher-dimensional remark, the rational-coefficient version and why it *does* admit Hamel pathology.
6. **§5 Where the trap recurs** — recurrence-in-applied-work documentation.
7. **References** — Cauchy, Hamel, Sierpiński, Steinhaus, Aczél, Kuczma, the main paper.

Submission target: 4 pages on the CRAS template; up to 6 if the dictionary table needs the room.
