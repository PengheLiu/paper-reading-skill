# paper-reading skill

`paper-reading` 是一个论文阅读 skill，基于李沐论文精读/串讲里的阅读习惯：先筛选，再三遍阅读，再拆论证链、实验和复现风险。

## 安装

### Claude Code（推荐）

在 Claude Code 里直接运行：

```
/plugin add PengheLiu/paper-reading-skill
```

安装完成后新开一个会话即可使用。

### Codex

```bash
./scripts/install.sh --codex
```

默认安装到 `$HOME/.codex/skills/paper-reading`。

### 手动安装（Claude Code）

```bash
./scripts/install.sh --claude
```

默认安装到 `$HOME/.claude/skills/paper-reading`。

## 怎么触发

安装后，显式触发最稳。

Claude Code:

```text
/paper-reading 帮我精读这篇论文: https://arxiv.org/abs/1706.03762
/paper-reading 比较这几篇论文的贡献、实验设计和可复现性
```

Codex:

```text
$paper-reading 帮我精读这篇论文: https://arxiv.org/abs/1706.03762
$paper-reading 按李沐三遍法比较这三篇论文，输出研究脉络和复现风险
```

自动触发依赖 `SKILL.md` frontmatter 里的 `description`，已包含 `paper-reading`、`论文阅读`、`论文精读`、`文献阅读`、`literature review`、`arXiv`、`DOI`、`PDF` 等触发词。

## 文件结构

```text
.claude-plugin/
  plugin.json          # Claude Code 插件元数据
  marketplace.json     # 允许本仓库作为独立 marketplace
skills/
  paper-reading/
    SKILL.md           # 核心工作流（Claude Code & Codex 通用）
    references/
      li-mu-method.md  # 三遍读法详细参考
    agents/
      openai.yaml      # Codex UI 元数据
scripts/
  install.sh           # 手动安装脚本（Codex / Claude Code）
```

## 验证

```bash
bash -n scripts/install.sh

VALIDATOR="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
[ -f "$VALIDATOR" ] && python3 "$VALIDATOR" skills/paper-reading || echo "Codex validator not found, skipping"
```
