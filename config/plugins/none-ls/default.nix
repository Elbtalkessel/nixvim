{ pkgs, ... }:
{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
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
      formatting = {
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
  keymaps = [
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
