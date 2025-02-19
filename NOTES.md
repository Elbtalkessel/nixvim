# Improvement Areas

## Python

- [ ] venv-selector: Replace fd with a custom utility to search .venv up from current file.
- [ ] venv-selector: After save lsp "forgets" about virtualenv.

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

## Features

- [ ] Mass find and replace, current specter solution is too clanky, maybe invest some time in learning how it works?

## Bugs

- Calling `nvim .` breaks shortcuts (showkeys-nvim?).
