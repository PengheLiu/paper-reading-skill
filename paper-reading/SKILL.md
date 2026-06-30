---
name: paper-reading
description: "Academic paper reading and literature research skill for paper-reading, 论文阅读, 论文精读, 文献阅读, literature review, arXiv, DOI, PDF, paper title, or paper list tasks. Use to triage papers, apply Li Mu inspired three-pass reading, do section-by-section deep reading, critique methods and experiments, compare papers, plan reproduction, find research ideas, or build a literature map."
---

# Paper Reading

## Overview

Use this skill to turn papers into research understanding: decide whether a paper is worth reading, read it at the right depth, reconstruct the argument, critique the evidence, and produce notes that can support implementation, review, or idea generation.

This skill is inspired by Li Mu's paper-reading series and his practice of fast triage, three-pass reading, and section-by-section close reading. For detailed checklists, source framing, and output templates, read `references/li-mu-method.md` when the user asks for a deep read, comparison, reproduction plan, literature survey, or research-idea mining.

## Invocation and Compatibility

Use the same skill folder in Codex and Claude Code. The shared contract is the `SKILL.md` file plus optional resources; `agents/openai.yaml` is Codex UI metadata and should not contain core workflow logic.

Explicit invocation is the most reliable:

- Codex: `$paper-reading 帮我精读这篇论文: <arXiv/PDF/DOI/title>`
- Claude Code: `/paper-reading 帮我精读这篇论文: <arXiv/PDF/DOI/title>`
- Path-based fallback: `Use the skill at ./paper-reading to read <paper>.`

Implicit invocation depends on the frontmatter `description`. Keep paper, PDF, arXiv, DOI, 论文阅读, 论文精读, literature review, reproduction, comparison, and literature map trigger terms in the description so agents can select the skill without loading this body first.

## Workflow

1. Establish the reading goal.
   Determine whether the user needs a quick decision, a learning note, a rigorous review, a reproduction plan, a comparison, or a literature map. If the user gave only a title or link, obtain the paper metadata and source text before analyzing.

2. Triage before reading deeply.
   Read title, abstract, introduction, section headings, conclusion, figures, and references first. Produce a short paper card: problem, context, claimed contribution, evidence type, venue/year if known, and whether to continue.

3. Apply the three-pass reading depth.
   Pass 1 gives the big picture and a read/skip decision. Pass 2 maps the content, figures, method, experiments, and core evidence while avoiding unnecessary proof-level detail. Pass 3 virtually reimplements the work: reconstruct assumptions, method steps, equations or pseudocode, experimental design, limitations, and likely missing details.

4. Read the paper as an argument.
   Track the chain from problem to claim to reason to evidence to limitation. Do not merely summarize sections. For each major claim, ask what result supports it, whether the baseline is fair, what assumption is hidden, and what would change your belief.

5. Build context around the paper.
   Use related work, shared citations, repeated author names, top venues, and follow-up papers to place the paper in a research lineage. For survey tasks, cluster papers by problem, method family, dataset, claim, and failure mode.

6. Output according to user intent.
   Prefer concise, structured notes over exhaustive section paraphrase. Preserve uncertainty explicitly. Separate what the paper says, what can be inferred, what remains unclear, and what should be verified from code, appendices, or follow-up work.

## Default Outputs

For a normal deep read, include:

- Paper card: title, authors, venue/year, link/source, domain, task, one-sentence thesis.
- Reading decision: why this paper is or is not worth deeper attention for the user's goal.
- Core contribution: what changed relative to prior work and why it matters.
- Method reconstruction: inputs, outputs, key assumptions, algorithm/model, training or proof structure.
- Evidence ledger: main claims, supporting experiments or arguments, strength of evidence, caveats.
- Critical takeaways: limitations, hidden assumptions, reproducibility risks, and missing comparisons.
- Research use: what to copy, what to avoid, follow-up papers, and possible ideas.

## Reading Rules

- Start broad, then go deep. Never begin by paraphrasing every paragraph unless the user explicitly asks for line-by-line reading.
- Prefer figures, tables, equations, ablations, and error analysis for evidence. Treat prose claims as claims, not proof.
- Challenge benchmark and experimental setup details: data leakage, unfair baselines, metric mismatch, scale effects, compute budget, hyperparameter search, and omitted negative results.
- Translate unfamiliar notation or jargon into plain language, but keep original symbols when needed for implementation.
- When the paper cannot be accessed or crucial details are missing, state the missing artifact and continue with the best-supported partial read.
