{
  lib,
  pkgs,
  config,
  ...
}:
let
  enableLs =
    lss:
    builtins.listToAttrs (
      builtins.map (ls: {
        name = ls;
        value = {
          enable = true;
        };
      }) lss
    );
in
{
  plugins = {
    lsp-format = {
      enable = config.lspFmt;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers =
        lib.recursiveUpdate
          (enableLs [
            "html"
            "lua_ls"
            "nixd"
            "markdown_oxide"
            "pyright"
            "gopls"
            "yamlls"
            "volar"
            "ts_ls"
          ])
          {
            nixd = {
              settings =
                let
                  flake = ''(builtins.getFlake "github:elythh/flake)""'';
                  flakeNixvim = ''(builtins.getFlake "github:elythh/nixvim)""'';
                in
                {
                  nixpkgs = {
                    expr = "import ${flake}.inputs.nixpkgs { }";
                  };
                  formatting = {
                    command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                  };
                  options = {
                    nixos.expr = ''${flake}.nixosConfigurations.grovetender.options'';
                    nixvim.expr = ''${flakeNixvim}.packages.${pkgs.system}.default.options'';
                  };
                };
            };
            yamlls = {
              settings = {
                schemaStore = {
                  enable = false;
                  url = "";
                };
              };
            };
          };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          # Use LSP saga keybinding instead
          # K = {
          #   action = "hover";
          #   desc = "Hover";
          # };
          # "<leader>cw" = {
          #   action = "workspace_symbol";
          #   desc = "Workspace Symbol";
          # };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        # diagnostic = {
        #   "<leader>cd" = {
        #     action = "open_float";
        #     desc = "Line Diagnostics";
        #   };
        #   "[d" = {
        #     action = "goto_next";
        #     desc = "Next Diagnostic";
        #   };
        #   "]d" = {
        #     action = "goto_prev";
        #     desc = "Previous Diagnostic";
        #   };
        # };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }

    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end;
  '';
}
