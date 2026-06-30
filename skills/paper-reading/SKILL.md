---
name: paper-reading
description: "Academic paper reading and literature research skill for paper-reading, 论文阅读, 论文精读, 文献阅读, literature review, arXiv, DOI, PDF, paper title, or paper list tasks. Use to triage papers, apply Li Mu inspired three-pass reading, do section-by-section deep reading, critique methods and experiments, compare papers, plan reproduction, find research ideas, or build a literature map."
allowed-tools: Bash, Write, Read, WebFetch
---

# Paper Reading

## Overview

Use this skill to turn papers into research understanding: decide whether a paper is worth reading, read it at the right depth, reconstruct the argument, critique the evidence, and produce notes that can support implementation, review, or idea generation.

This skill is inspired by Li Mu's paper-reading series and his practice of fast triage, three-pass reading, and section-by-section close reading. For detailed checklists, source framing, and output templates, read `references/li-mu-method.md` before starting any deep read, comparison, reproduction plan, literature survey, or research-idea mining task.

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

6. Output: generate HTML note and open in browser.
   After completing the analysis, produce a self-contained HTML reading note and serve it locally. See the HTML Output section below.

## Reading Rules

- Start broad, then go deep. Never begin by paraphrasing every paragraph unless the user explicitly asks for line-by-line reading.
- Prefer figures, tables, equations, ablations, and error analysis for evidence. Treat prose claims as claims, not proof.
- Challenge benchmark and experimental setup details: data leakage, unfair baselines, metric mismatch, scale effects, compute budget, hyperparameter search, and omitted negative results.
- Translate unfamiliar notation or jargon into plain language, but keep original symbols when needed for implementation.
- When the paper cannot be accessed or crucial details are missing, state the missing artifact and continue with the best-supported partial read.

## HTML Output

After completing the reading analysis, always produce a local HTML reading note and open it in the browser. Do not skip this step for deep reads.

### Step 1: Determine output path

```bash
mkdir -p ~/paper-notes
SLUG=$(echo "<paper-title>" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | cut -c1-60)
OUTPUT="$HOME/paper-notes/${SLUG}.html"
echo "Output: $OUTPUT"
```

### Step 2: Write the HTML file

Write a single self-contained HTML file to `$OUTPUT`. All CSS and JS must be inline — no external fetches except the two CDN libraries below, which load from trusted sources:

- MathJax for LaTeX math: load from `https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js`
- Mermaid for diagrams: load from `https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js`

#### Required structure

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{paper title}</title>
  <script>
    MathJax = { tex: { inlineMath: [['$','$'],['\\(','\\)']], displayMath: [['$$','$$'],['\\[','\\]']] } };
  </script>
  <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" async></script>
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <style>
    /* inline all styles — see design spec below */
  </style>
</head>
<body>
  <!-- content sections — see content spec below -->
  <script>mermaid.initialize({startOnLoad:true, theme:'neutral'});</script>
</body>
</html>
```

#### Design spec

Use a clean academic reading layout. Suggested styles:

```css
body { max-width: 860px; margin: 0 auto; padding: 2rem; font-family: 'Georgia', serif; color: #222; line-height: 1.75; background: #fafaf8; }
h1 { font-size: 1.6rem; border-bottom: 2px solid #333; padding-bottom: 0.4rem; margin-top: 2rem; }
h2 { font-size: 1.2rem; color: #444; margin-top: 1.8rem; }
h3 { font-size: 1rem; color: #555; }
.paper-card { background: #f0ede6; border-left: 4px solid #8b7355; padding: 1rem 1.2rem; border-radius: 4px; margin: 1.2rem 0; }
.paper-card p { margin: 0.3rem 0; }
.claim-table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
.claim-table th { background: #e8e4db; text-align: left; padding: 0.5rem 0.7rem; }
.claim-table td { border-top: 1px solid #ddd; padding: 0.5rem 0.7rem; vertical-align: top; }
.badge { display: inline-block; padding: 0.15rem 0.5rem; border-radius: 3px; font-size: 0.78rem; font-family: monospace; }
.badge-strong { background: #d4edda; color: #155724; }
.badge-weak   { background: #fff3cd; color: #856404; }
.badge-unsup  { background: #f8d7da; color: #721c24; }
.mermaid { margin: 1.2rem 0; }
blockquote { border-left: 3px solid #bbb; margin: 1rem 0; padding: 0.5rem 1rem; color: #555; font-style: italic; }
code { background: #f0ede6; padding: 0.1rem 0.3rem; border-radius: 2px; font-size: 0.88em; }
pre { background: #f0ede6; padding: 1rem; border-radius: 4px; overflow-x: auto; }
.tag { display: inline-block; background: #e8e4db; padding: 0.1rem 0.5rem; border-radius: 10px; font-size: 0.8rem; margin: 0.1rem; }
nav { position: sticky; top: 0; background: #fafaf8ee; border-bottom: 1px solid #ddd; padding: 0.5rem 0; margin-bottom: 1.5rem; font-size: 0.85rem; }
nav a { margin-right: 1rem; color: #5a4a3a; text-decoration: none; }
nav a:hover { text-decoration: underline; }
```

#### Content spec

Produce all sections in the **user's language** (detect from the invocation prompt). Sections:

1. **Sticky nav bar** — anchor links to each section below.

2. **Paper Card** (`<div class="paper-card">`) — title, authors, venue/year, source link, field/task, one-sentence thesis, tags (`<span class="tag">`), reading decision (Read / Skim / Skip with one-line reason).

3. **Big Picture** — problem, prior limitation, core idea, main contribution, main evidence. Use plain prose, 3–5 short paragraphs.

4. **Method** — architecture or algorithm as a Mermaid flowchart (`<div class="mermaid">`), followed by inputs/outputs, key assumptions, training/inference flow. Inline LaTeX for any equations: `$x = \sigma(Wx + b)$` for inline, `$$...$$` for display.

5. **Evidence Ledger** — an HTML table (`<table class="claim-table">`) with columns: Claim, Evidence, Strength (badge: strong / weak / unsupported), Caveat, Verification needed.

6. **Critique** — strengths, weaknesses, hidden assumptions, reproducibility risks, missing baselines. Use a two-column HTML table or bullet list.

7. **Research Use** — what to reuse, what to avoid, follow-up papers (linked if arXiv), possible research ideas.

8. **Footer** — "Generated by paper-reading skill · {date}" in small gray text.

Keep the tone analytical. Never pad with filler. Mark inferences explicitly with "（推断）" or "(inferred)".

### Step 3: Find a free port and serve

```bash
# Find a free port starting from 7410
PORT=7410
while lsof -i :$PORT >/dev/null 2>&1; do PORT=$((PORT+1)); done

# Start Python HTTP server in background from ~/paper-notes
python3 -m http.server $PORT --directory "$HOME/paper-notes" \
  --bind 127.0.0.1 >/tmp/paper-notes-server.log 2>&1 &
SERVER_PID=$!
echo $SERVER_PID > /tmp/paper-notes-server.pid

# Wait for server to be ready
for i in $(seq 1 10); do
  curl -s "http://localhost:$PORT/" >/dev/null 2>&1 && break
  sleep 0.5
done

echo "Serving at http://localhost:$PORT"
echo "Note: http://localhost:$PORT/${SLUG}.html"
```

### Step 4: Open in browser

```bash
open "http://localhost:$PORT/${SLUG}.html"
```

On Linux, use `xdg-open` instead of `open`.

### Step 5: Report to user

After the browser opens, report in one line:

```
笔记已生成并在浏览器中打开: http://localhost:{PORT}/{slug}.html
文件保存于: ~/paper-notes/{slug}.html
停止服务: kill $(cat /tmp/paper-notes-server.pid)
```
