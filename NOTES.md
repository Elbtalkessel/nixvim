# Improvement Areas

## TODO(python-venv): Implement automatic activation of the nearest virtual environment.

It works, but can be a bit faster, for my usecase I only need to check directories up from the current buffer until the cwd to find a `.venv` directory. Doesn't seem `fd` or `find` can do it, can be a little project on its own.

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

- [ ] Picker: make lazygit item highlight darker like picker has.
- [ ] LazyGit: fullscreen?

## Bugs

- Calling `nvim .` breaks shortcuts (showkeys-nvim?).
