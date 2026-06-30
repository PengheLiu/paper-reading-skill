# mli-paper-reading-skill

基于李沐论文精读方法的论文阅读 skill，适用于 Claude Code 和 Codex。

先筛选，再三遍阅读，再拆论证链、实验和复现风险，最后生成本地 HTML 阅读笔记（含原文插图、MathJax 公式、Mermaid 架构图）。

## 安装

### Claude Code（推荐）

```bash
claude plugin marketplace add PengheLiu/mli-paper-reading-skill
claude plugin install mli-paper-reading-skill@mli-paper-reading-skill
```

安装后新开一个 Claude Code 会话即可使用。

### Codex / 手动安装

```bash
git clone https://github.com/PengheLiu/mli-paper-reading-skill
cd mli-paper-reading-skill
./scripts/install.sh          # 同时安装到 Codex 和 Claude Code
./scripts/install.sh --claude # 仅 Claude Code
./scripts/install.sh --codex  # 仅 Codex
./scripts/install.sh --link   # 用软链，改源文件后立即生效
```

默认安装路径：

| 平台 | 路径 |
|---|---|
| Claude Code | `~/.claude/skills/mli-paper-reading` |
| Codex | `~/.codex/skills/mli-paper-reading` |

## 使用

### Claude Code

```
/mli-paper-reading 帮我精读这篇论文: https://arxiv.org/abs/1706.03762
/mli-paper-reading 比较这几篇论文的贡献、实验设计和可复现性
```

### Codex

```
$mli-paper-reading 帮我精读这篇论文: https://arxiv.org/abs/1706.03762
$mli-paper-reading 按李沐三遍法比较这三篇论文，输出研究脉络和复现风险
```

支持输入格式：arXiv 链接、PDF 链接、DOI、本地 PDF 路径、论文标题。

## 输出

读完后自动在 `~/paper-notes/` 生成一个自包含 HTML 文件，用 Python 内置 `http.server` 起本地服务并打开浏览器：

- **论文原图**：从 PDF 提取并 base64 内嵌，文件离线可用
- **MathJax 公式**：LaTeX 原样渲染
- **Mermaid 架构图**：无 PDF 时作为补充
- **证据账本**：主张 / 证据 / 强度 / 注意事项表格
- **批判性评价**：隐含假设、复现风险、缺失对照

停止本地服务：

```bash
kill $(cat /tmp/paper-notes-server.pid)
```

## 依赖

唯一需要手动安装的包：

```bash
python3 -m pip install pymupdf --user
```

其余依赖（Python 3.7+、`http.server`、`lsof`、`curl`、`open`）在 macOS 上均为系统内置。详见 `skills/mli-paper-reading/SKILL.md` 的 Dependencies 节，包含一键自检脚本。

## 仓库结构

```
mli-paper-reading-skill/
├── .claude-plugin/
│   ├── plugin.json          # Claude Code 插件元数据
│   └── marketplace.json     # 允许本仓库作为独立 marketplace
├── skills/
│   └── mli-paper-reading/   # Skill 核心目录（Claude Code & Codex 通用）
│       ├── SKILL.md         # 触发描述 + 完整工作流
│       ├── references/
│       │   └── li-mu-method.md   # 三遍读法参考、输出模板
│       └── agents/
│           └── openai.yaml  # Codex UI 元数据
├── scripts/
│   └── install.sh           # 手动安装脚本
└── README.md
```

## 验证

```bash
bash -n scripts/install.sh

VALIDATOR="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
[ -f "$VALIDATOR" ] && python3 "$VALIDATOR" skills/mli-paper-reading \
  || echo "Codex validator not found, skipping"
```
