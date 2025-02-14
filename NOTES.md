# Improvement Areas

## Critical Issues

No critical issues identified at this time.

## Major Concerns

### Python Environment Management

- Implement automatic activation of the nearest virtual environment.

### LSP Performance

- Investigate and address suboptimal performance in large projects.
- Consider selectively disabling certain LSP features to improve responsiveness.

## Minor Enhancements

### HTMX Language Server

- Current HTMX language server configuration is insufficient.
  > Version information retrieval fails with the message: "Usage: htmx-lsp [OPTIONS] Options: -f, --file The file to pipe log…"

### Terraform Integration

- Terraform support is currently disabled due to an error.
- Consider resolving the error for potential future use:
  "Failed to run 'after' hook for nvim-lint: /nix/store/0h5zcqmw858v2k15xjnwlp045fz090wj-init.lua:0: attempt to index field 'terraform' (a nil value)"

### Configuration Centralization

- Consolidate supported file format configurations for LSP, linting, and formatting in a single location.
- Implement a unified system to enable/disable features across all tools simultaneously.

### Snacks Plugin UI

- Improve the visual layout of file list and preview for a more aesthetically pleasing side-by-side arrangement.

### Markdown Setup

- Evaluate the necessity of the current complex markdown configuration.

### Neovim Shortcut Issue

- Investigate why `nvim .` command breaks shortcuts.
- Note: This is not an issue when using `nvim` without a path argument.

## Resolved Issues

### Formatting Configuration

- Fixed: Conform plugin now correctly honors .prettierrc settings.
- Root cause: LSP fallback interfered with Conform's configuration parsing.

### Markdown Spell Checking

- Resolved: Unnecessary spelling downloads for markdown files.
- Solution: Now configurable through options.nix
