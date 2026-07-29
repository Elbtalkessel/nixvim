{ pkgs, lib, ... }:
{
  extraPackages = with pkgs; [ shfmt ];

  plugins.conform-nvim = {
    enable = true;

    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWrite" ];
    };
    luaConfig.pre = # lua
      ''
        local slow_format_filetypes = {}
      '';
    settings = {
      # https://nix-community.github.io/nixvim/plugins/conform-nvim/settings/index.html
      # slow_format_filetypes not included
      format_on_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            local function on_format(err)
              if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
              end
            end

            return { timeout_ms = 200, lsp_fallback = true }, on_format
           end
        '';
      format_after_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { lsp_fallback = true }
          end
        '';
      log_level = "warn";
      notify_on_error = false;
      notify_no_formatters = false;
      formatters = {
        shellcheck = {
          command = lib.getExe pkgs.shellcheck;
        };
        shfmt = {
          command = lib.getExe pkgs.shfmt;
        };
        shellharden = {
          command = lib.getExe pkgs.shellharden;
        };
        squeeze_blanks = {
          command = lib.getExe' pkgs.coreutils "cat";
        };
        gleamfmt = {
          command = "${lib.getExe pkgs.gleam} format";
        };
      };
      formatters_by_ft = {
        python = [ "black" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        markdown = [ "prettier" ];
        yaml = [ "yamlfmt" ];
        bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        gleam = [ "gleamfmt" ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };
    };
  };

  userCommands = {
    # https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    "FormatDisable" = {
      bang = true;
      desc = "Toggle conform (autoformat) on save. Use bang to disable for current buffer only.";
      command = # lua
        ''
          function(args)
            if args.bang then
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end
        '';
    };
    "FormatEnable" = {
      desc = "Re-enable autoformat-on-save";
      command = # lua
        ''
          function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end
        '';
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
        "x"
      ];
      key = "<leader>tfo";
      action = "<CMD>FormatDisable<CR>";
      options = {
        desc = "toggle formatting off";
      };
    }
    {
      mode = [
        "n"
        "v"
        "x"
      ];
      key = "<leader>tfb";
      action = "<CMD>FormatEnable<CR>";
      options = {
        desc = "toggle formatting back on";
      };
    }
  ];
}
