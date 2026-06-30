# Li Mu Inspired Paper Reading Method

Use this reference for deep reads, literature surveys, paper comparisons, review-style critiques, reproduction planning, and research-idea mining.

## Source Basis

The skill synthesizes these public sources and observed practices:

- Li Mu's `mli/paper-reading` repository, which starts the series with `如何读论文`, then demonstrates many `论文精读`, `逐段精读`, and `串讲` readings across deep learning papers: https://github.com/mli/paper-reading
- The Bilibili video `如何读论文【论文精读·1】`, published by `跟李沐学AI`, described as `三步法快速读文献`: https://www.bilibili.com/video/BV1H44y1t75x/
- S. Keshav's `How to Read a Paper`, which formalizes the three-pass approach and the five Cs: https://ccr.sigcomm.org/online/files/p83-keshavA.pdf
- Li Mu's `研究的艺术` videos in the same repository: reader connection, problem importance, story and argument, reasons/evidence/warrants.

This is a practical synthesis, not a transcript. Avoid attributing phrasing to Li Mu unless you have verified the exact quote.

## Distilled Principles

1. Read with a purpose.
   Before deep reading, identify why this paper matters to the user: learn a field, implement a method, review a submission, compare approaches, find ideas, or decide whether to skip it.

2. Use passes, not one linear read.
   A paper should be read in increasing depth. Stop early if the paper is irrelevant, too background-dependent for the current goal, or unsupported by evidence.

3. First understand the research story.
   Extract problem, motivation, prior limitation, proposed idea, evidence, and broader implication. The story is usually more valuable than a section-by-section paraphrase.

4. Treat the paper as a chain of claims.
   Claims require reasons, evidence, and warrants. A good reading note should show which claims are well supported, weakly supported, or unsupported.

5. Use close reading selectively.
   Section-by-section or paragraph-level reading is reserved for important papers, implementation targets, confusing arguments, or reviewer-level critique.

6. Convert reading into reusable output.
   The final artifact should support later action: explaining the paper, implementing it, comparing it to other work, writing a review, or generating research directions.

## Three-Pass Procedure

### Pass 1: Triage and Big Picture

Goal: decide whether to keep reading and capture the paper's shape.

Read:

- Title, abstract, introduction.
- Section and subsection headings.
- Conclusion and limitations.
- Figures, tables, and captions at a glance.
- References, looking for familiar papers, repeated names, and important venues.

Answer the five Cs:

- Category: survey, method, theory, benchmark, dataset, system, empirical study, position paper, or application.
- Context: predecessor papers, task setting, assumptions, and research lineage.
- Correctness: whether the assumptions look plausible from the first pass.
- Contributions: the main claimed novelty or useful synthesis.
- Clarity: whether the paper is readable enough for the intended goal.

Output:

- One-sentence thesis.
- Read/skim/skip decision.
- Background dependencies.
- Questions to resolve in Pass 2.

### Pass 2: Content Map

Goal: understand the content and evidence without getting stuck in every proof or implementation detail.

Do:

- Summarize each major section in one or two bullets.
- Build a method map: input, output, architecture/algorithm, objective, training or proof flow, inference/use flow.
- Inspect figures and tables carefully. Check axes, metrics, baselines, ablations, error bars if relevant, and whether the results match the claims.
- Mark unknown terms, unread references, datasets, benchmark protocols, and equations that gate understanding.
- Identify which prior work the paper is improving, simplifying, scaling, or contradicting.

Output:

- A 200 to 400 word plain-language summary.
- A contribution list with evidence.
- A table of claims, support, caveats, and verification needs.
- A list of references or concepts to read before Pass 3.

### Pass 3: Virtual Reimplementation and Critique

Goal: understand the paper deeply enough to reproduce, review, teach, or extend it.

Do:

- Reconstruct the method from the problem statement without looking at the authors' exact presentation, then compare your reconstruction to the paper.
- Challenge each assumption: data distribution, model capacity, training budget, metric choice, independence assumptions, evaluation protocol, proof conditions.
- Rewrite key equations, algorithms, or experimental steps in your own notation or pseudocode.
- Infer missing implementation details and label them as assumptions.
- Check whether every major claim has direct evidence.
- Generate alternatives: simpler baseline, stronger baseline, ablation, negative control, or follow-up experiment.

Output:

- Reimplementation recipe.
- Reviewer-style strengths and weaknesses.
- Failure modes and hidden assumptions.
- Follow-up experiments and research ideas.

## Section Question Bank

### Title and Abstract

- What exact problem is promised?
- What is the claimed delta over prior work?
- Is the main claim empirical, theoretical, engineering, or conceptual?
- What result would have to be true for the paper to matter?

### Introduction

- What pain point or gap is being sold?
- Is the gap real, or mostly rhetorical?
- What does the paper assume the reader already knows?
- What would be the simplest baseline solution?

### Related Work

- Which research families are being compared?
- Which papers appear repeatedly across citations?
- What prior work is framed as insufficient, and is that framing fair?
- What important adjacent work might be omitted?

### Method

- What are the inputs and outputs?
- What is the minimal algorithm in pseudocode?
- Which parts are novel versus borrowed?
- Which hyperparameters, losses, data choices, or system choices look decisive?
- What must be true for the method to work?

### Experiments

- What question does each experiment answer?
- Are baselines strong, current, and fairly tuned?
- Are metrics aligned with the paper's claims?
- Are datasets representative, contaminated, or too narrow?
- Do ablations isolate the claimed contribution?
- Does scale, compute, or data quantity explain the gains?
- Are failure cases, variance, and negative results shown?

### Conclusion and Limitations

- What does the paper admit it cannot solve?
- Which claims are softened compared with the abstract?
- What should be tested next?
- What would invalidate the paper's main conclusion?

## Literature Survey Mode

Use this when the user asks to understand a field, compare many papers, or build a reading list.

1. Seed the field with three to five recent or canonical papers.
2. Do Pass 1 on each paper.
3. Extract shared citations, repeated author names, datasets, benchmarks, and venues.
4. Find surveys or tutorial papers if available.
5. Cluster papers by problem, method family, data, evaluation, and claim.
6. Identify the backbone papers: oldest root, highest-impact method, strongest benchmark, current state of the art, and dissenting or negative-result papers.
7. Produce a reading order: prerequisite background, canonical papers, representative modern papers, and open-problem papers.

## Output Templates

### Deep Reading Note

```markdown
## Paper Card
- Title:
- Authors / Venue / Year:
- Link or source:
- Field / task:
- One-sentence thesis:
- Why read this:

## Big Picture
- Problem:
- Prior limitation:
- Core idea:
- Main contribution:
- Main evidence:

## Method Reconstruction
- Inputs / outputs:
- Key assumptions:
- Algorithm or model:
- Objective or proof structure:
- Training / inference / system details:
- Missing details to verify:

## Evidence Ledger
| Claim | Evidence | Strength | Caveat | Verification |
| --- | --- | --- | --- | --- |

## Critique
- Strengths:
- Weaknesses:
- Hidden assumptions:
- Reproducibility risks:
- Missing baselines or ablations:

## Research Use
- What to reuse:
- What to avoid:
- Follow-up papers:
- Possible ideas:
```

### Quick Triage Note

```markdown
- Paper:
- Category:
- Context:
- Contribution:
- Correctness risk:
- Clarity:
- Decision:
- Next action:
```

### Comparison Note

```markdown
| Dimension | Paper A | Paper B | Implication |
| --- | --- | --- | --- |
| Problem framing | | | |
| Method idea | | | |
| Assumptions | | | |
| Evidence | | | |
| Strength | | | |
| Weakness | | | |
| Best use case | | | |
```

## Quality Bar

- Separate summary from critique.
- Mark inference as inference.
- Prefer concrete evidence over adjectives.
- Do not overclaim novelty unless the related-work and citation context support it.
- When reading ML papers, pay special attention to data construction, benchmark protocol, compute budget, ablations, scaling effects, and code availability.
- When reading theory papers, pay special attention to assumptions, theorem conditions, proof gaps, examples, and whether the result changes practical understanding.
- When reading systems papers, pay special attention to workload realism, bottleneck analysis, deployment assumptions, reproducibility, and tail behavior.
