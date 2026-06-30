# paper-reading skill

`paper-reading` 是一个论文阅读 skill，基于李沐论文精读/串讲里的阅读习惯：先筛选，再三遍阅读，再拆论证链、实验和复现风险。

这个仓库把核心能力放在一个标准 skill 目录里：

```text
paper-reading/
  SKILL.md
  references/li-mu-method.md
  agents/openai.yaml
```

## 怎么触发

显式触发最稳。

Codex:

```text
$paper-reading 帮我精读这篇论文: https://arxiv.org/abs/1706.03762
$paper-reading 按李沐三遍法比较这三篇论文，输出研究脉络和复现风险
```

Claude Code:

```text
/paper-reading 帮我精读这篇论文: ./paper.pdf
/paper-reading 比较这几篇论文的贡献、实验设计和可复现性
```

路径兜底，适合还没安装或自动发现失败时使用：

```text
Use the skill at ./paper-reading to read this paper and produce a deep research note.
```

自动触发依赖 `paper-reading/SKILL.md` frontmatter 里的 `description`。所以描述里已经加入了 `paper-reading`、`论文阅读`、`论文精读`、`文献阅读`、`literature review`、`arXiv`、`DOI`、`PDF`、复现、比较和文献地图等触发词。

## Codex 和 Claude Code 通用吗

可以通用。两边都围绕 `SKILL.md` 这种 skill 目录工作，核心工作流不要写进某个平台专属配置里即可。

这个包的兼容策略是：

- `paper-reading/SKILL.md`: 通用触发描述和执行流程。
- `paper-reading/references/`: 通用方法论和模板。
- `paper-reading/agents/openai.yaml`: Codex 展示元数据；不承载核心逻辑。

实际安装时，把同一个 `paper-reading` 目录复制或软链到不同产品扫描的位置。

## 安装

默认同时安装到 Codex 和 Claude Code 的用户级目录：

```bash
./scripts/install.sh
```

默认路径：

- Codex: `$HOME/.agents/skills/paper-reading`
- Claude Code: `$HOME/.claude/skills/paper-reading`

只安装其中一个：

```bash
./scripts/install.sh --codex
./scripts/install.sh --claude
```

使用软链，方便后续改仓库里的源文件后立即生效：

```bash
./scripts/install.sh --link
```

安装到当前项目的本地 skill 目录：

```bash
./scripts/install.sh --project --link
```

如果你的本机 Codex 版本仍使用旧目录，可以覆写目标路径：

```bash
CODEX_SKILLS_DIR="$HOME/.codex/skills" ./scripts/install.sh --codex
```

Claude Code 目录也可以覆写：

```bash
CLAUDE_SKILLS_DIR="$HOME/.claude/skills" ./scripts/install.sh --claude
```

安装后新开一个会话，或在没有出现时重启对应工具。

## 验证

```bash
# 语法检查
bash -n scripts/install.sh

# 如果本机安装了 Codex 且有 quick_validate.py，可以用 Codex 验证器检查 frontmatter：
VALIDATOR="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
[ -f "$VALIDATOR" ] && python3 "$VALIDATOR" paper-reading || echo "Codex validator not found, skipping"
```
