{ pkgs, config, ... }:
let
  mkFmt =
    fmt: ftype:
    builtins.listToAttrs (
      map (t: {
        name = t;
        value = fmt;
      }) ftype
    );
in
{

  config = {
    extraPackages = with pkgs; [ shfmt ];

    # region keymaps
    keymaps = [
      # toggle autoformat, https://github.com/stevearc/conform.nvim/issues/192#issuecomment-2573170631
      {
        mode = "n";
        key = "<leader>tf";
        action.__raw = ''
          function()
            -- If autoformat is currently disabled for this buffer,
            -- then enable it, otherwise disable it
            if vim.b.disable_autoformat then
              vim.cmd 'FormatEnable'
              vim.notify 'Enabled autoformat for current buffer'
            else
              vim.cmd 'FormatDisable'
              vim.notify 'Disabled autoformat for current buffer'
            end
          end
        '';
        options = {
          desc = "Toggle autoformat for current buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>tF";
        action.__raw = ''
          function()
            -- If autoformat is currently disabled globally,
            -- then enable it globally, otherwise disable it globally
            if vim.g.disable_autoformat then
              vim.cmd 'FormatEnable!'
              vim.notify 'Enabled autoformat globally'
            else
              vim.cmd 'FormatDisable!'
              vim.notify 'Disabled autoformat globally'
            end
          end
        '';
        options = {
          desc = "Toggle autoformat globally";
        };
      }
    ];
    # endregion keymaps

    # region userCommands
    userCommands = {
      FormatDisable = {
        bang = true;
        desc = "Disable autoformat";
        command.__raw = ''
          function(args)
            if args.bang then
              vim.g.disable_autoformat = true
            else
              vim.b.disable_autoformat = true
            end
          end
        '';
      };
      FormatEnable = {
        bang = true;
        desc = "Enable autoformat";
        command.__raw = ''
          function(args)
            vim.g.disable_autoformat = false
            vim.b.disable_autoformat = false
          end
        '';
      };
    };

    # region conform-nvim
    plugins.conform-nvim = {
      enable = true;

      lazyLoad.settings = {
        cmd = [
          "ConformInfo"
        ];
        event = [ "BufWrite" ];
      };

      # region settings
      settings =
        let
          lsp_fallback = if config.lspFmt then "not disable_filetypes[vim.bo[bufnr].filetype]" else "false";
        in
        {
          format_on_save = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              local disable_filetypes = { c = false, cpp = false }
              return {
                timeout_ms = 500,
                lsp_fallback = ${lsp_fallback},
              }
            end
          '';
          notify_on_error = true;

          # region formatters_by_ft
          formatters_by_ft =
            {
              liquidsoap = [ "liquidsoap-prettier" ];
              python = [ "black" ];
              lua = [ "stylua" ];
              nix = [ "nixfmt" ];
              yaml = [
                "yamllint"
                "yamlfmt"
              ];
            }
            // mkFmt [ "shfmt" ] [ "bash" "sh" ]
            //
              mkFmt
                {
                  __unkeyed-1 = "prettierd";
                  __unkeyed-2 = "prettier";
                  stop_after_first = true;
                }
                [
                  "html"
                  "css"
                  "javascript"
                  "javascriptreact"
                  "typescript"
                  "typescriptreact"
                  "markdown"
                ];
          # endregion formatters_by_ft

        };
      # endregion settings

    };
    # endregion conform-nvim

  };
  # endregion config
}
