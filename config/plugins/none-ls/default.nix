{
  pkgs,
  lib,
  config,
  ...
}:
{
  plugins.none-ls = rec {
    enable = true;
    # Leaving it for future reference, but
    # disabling because LSP should LSPing and formatters should format
    # the code. Plus it needs to be adjusted and be toggleable
    # as conform.
    enableLspFormat = false;
    settings = {
      updateInInsert = false;
    };
    sources = {
      code_actions = {
        # TODO(pipe): Use https://github.com/molybdenumsoftware/statix for pipe support.
        #statix.enable = true;
      };
      diagnostics = {
        # TODO(pipe): Use https://github.com/molybdenumsoftware/statix for pipe support.
        #statix.enable = true;
        yamllint.enable = true;
      };
      formatting = lib.mkIf enableLspFormat {
        nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
        black = {
          enable = true;
          settings = ''
            {
              extra_args = { "--fast" },
            }
          '';
        };
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings = ''
            {
              extra_args = { "--no-semi" },
              disabled_filetypes = {
                "markdown"
              }
            }
          '';
        };
        stylua.enable = true;
        yamlfmt = {
          # Idiotic formatting
          enable = false;
        };
        hclfmt.enable = true;
        crystal_format = {
          enable = true;
        };
      };
    };
  };
  keymaps = lib.mkIf config.plugins.none-ls.enableLspFormat [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
