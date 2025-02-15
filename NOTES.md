# Improvement Areas

## TODO(python-venv): Implement automatic activation of the nearest virtual environment.

https://github.com/AckslD/swenv.nvim looks for virtualenv at home directory or, if project.nvim plugin is installed - inside a project directory.
For my usecase I need to look up from the current directory up until cwd and activate first found `.venv`. Alternatively Snacks has project picker
but I need to verify if I can somehow retrieve project root dir path from it.

## LSP

- [ ] HTMX support
- [ ] Investigate and address suboptimal performance in large projects. Consider selectively disabling certain LSP features to improve responsiveness.

## TODO(conf): Configuration Centralization

Consolidate supported file format configurations for LSP, linting, and formatting in a single location.
Implement a unified system to enable/disable features across all tools simultaneously.

## TODO(cleanup): Plugin / Configuration cleanup

- [ ] Markdown: remove markview or make rendering optional.
- [ ] Dressing: replaced by snacks.
- [ ] Telescope: replaced by Snacks.
- [ ] Fzf-lua: not sure why do I need this.

## Interface

- [ ] Picker: make highlight darker.
- [ ] LazyGit: fullscreen?

## Bugs

- Calling `nvim .` breaks shortcuts (showkeys-nvim?).
