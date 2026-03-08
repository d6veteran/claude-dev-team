# claude-dev-team — Development Log

A living record of architectural decisions, milestones, key insights, and strategic direction.
Auto-maintained via Claude devlog skill. Entries are reverse-chronological.

---

## [2026-03-08] v0.2 shipped — in-session persona switching via slash commands

**Category:** `milestone`
**Tags:** `feature`, `slash-commands`, `v0.2`, `bash-compat`

### Summary
Shipped v0.2: in-session persona switching without restarting Claude Code. Users can now type `/robin`, `/akira`, `/sasha`, `/toni`, or `/river` in any Claude Code session to switch personas immediately. Also added `claude-team install-commands` subcommand and switched the installer to symlink the CLI.

### Detail
- Added `commands/` directory with 6 slash command files: one per team member + `/team`
- Each command file calls `claude-team use <name>` (persistent state) AND embeds the full persona inline (immediate in-session adoption — no restart required)
- Added `cmd_install_commands()` to `bin/claude-team`: copies commands to `~/.claude/commands/`, lists installed commands with usage
- Updated `install.sh` to install slash commands as part of the standard install flow
- Changed CLI install from `cp` to `ln -sf` (symlink) — repo edits take effect immediately without reinstalling
- Fixed bash 3.2 compat in install.sh: replaced `${var^^}` with `tr '[:lower:]' '[:upper:]'`
- Updated README to reflect v0.2 as current, moved slash commands from roadmap to shipped

### Related
- v0.3+ backlog: session handoff context, local profile overrides, new members (Alex/DevOps, Morgan/Security, Jordan/Data)

---

## [2026-03-07] v0.1 shipped — blog posts, roadmap, and gitignore cleanup

**Category:** `milestone`
**Tags:** `launch`, `content`, `roadmap`, `v0.1`

### Summary
Completed the v0.1 feature set for claude-dev-team: five personas, coordinator layer, bash 3.2-compatible CLI, and installer. Added a PMM-voice blog post series and a product roadmap to the README.

### Detail
- Five team member personas shipped: Robin (QA/Testing), Akira (Backend), Sasha (Frontend), Toni (Product Marketing), River (Product)
- Coordinator layer added as a separate CLAUDE.md block — survives team member switches, suggests team member + operating mode (Plan / Ask before edits / Edit automatically) at task start and on domain shifts
- Fixed bash 3.2 compatibility (macOS ships bash 3.2; removed `${var^}` and `${var,,}` in favor of `awk`/`tr` helpers)
- Fixed wildcard bug in `cmd_list` where empty `$active` matched every team member
- Fixed coordinator appearing in `claude-team list` output
- Wrote five blog posts in Toni's PMM voice (benefit-first, audience-obsessed, outcome-focused) — one per team member, stored in `claude-dev-team-blog-posts.md` outside the repo
- Added roadmap to README covering: v0.1 current state, v0.2 slash command shortcuts (`/robin`, `/sasha-plan`, etc. via `.claude/commands/`), and v0.3+ backlog
- Added `claude-dev-team-blog-posts.md` to `.gitignore` (draft content, not repo)

### Related
- Slash command implementation planned for v0.2 — Claude Code `.claude/commands/` Markdown files invoking `claude-team use <name>`
