# Painpoints

- markdown: tries to download spelling I don't need.
- markdown: saving file produces an error.
- markdown: do I need it to be this complex?
- python: activate closest virtualenv automatically.
- htmx: it is not enough to just enable htmx ls:
  > version: `Usage: htmx-lsp [OPTIONS]  Options:   -f, --file <FILE>    The file to pipe log…` (Failed to get version)
- nvim: when starting an error show
- snacks: looks ugly when file list and file preview not side-by-side.
- lsp, lint, fmt: list of supported file formats should be somewhere in a single place, so enabling or disabling a file format will disable bothlsp and linter.
- terraform: is disabled because it throws an error (and I don't need it), but maybe it better to resolve the error?
  > Failed to run 'after' hook for nvim-lint: /nix/store/0h5zcqmw858v2k15xjnwlp045fz090wj-init.lua:0: attempt to index field 'terraform' (a nil value)
- lint, fmt (conform): current configuration causes an error on save creating a lag, temporary disable until not resolved.
  > Error detected while processing BufWritePre Autocommands for "_"..BufWritePre Autocommands for "_":
