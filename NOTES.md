# Painpoints

## Critical

- fmt (conform): does not honor .prettierrc (with and without extension).

## Major

- ~~markdown: tries to download spelling I don't need.~~ now configurable through options.nix
- python: activate closest virtualenv automatically.
- lsp: it seems it is lsp issue, performance is subpar in large project, maybe disable some of them will help?
- nvim: after opening all shortcuts does not work, bringing up a command prompt and closing it resolve the issue.

## Minor

- htmx: it is not enough to just enable htmx ls:
  > version: `Usage: htmx-lsp [OPTIONS]  Options:   -f, --file <FILE>    The file to pipe log…` (Failed to get version)
- terraform: is disabled because it throws an error (and I don't need it), but maybe it better to resolve the error?
  > Failed to run 'after' hook for nvim-lint: /nix/store/0h5zcqmw858v2k15xjnwlp045fz090wj-init.lua:0: attempt to index field 'terraform' (a nil value)
- lsp, lint, fmt: list of supported file formats should be somewhere in a single place, so enabling or disabling a file format will disable bothlsp and linter.
- snacks: looks ugly when file list and file preview not side-by-side.
- markdown: do I need it to be this complex?
