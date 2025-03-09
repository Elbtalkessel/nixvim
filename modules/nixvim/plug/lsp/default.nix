{
  lib,
  pkgs,
  config,
  ...
}:
let
  /**
    Builds attribute set for a set of language defininitions based on languages enabled in options.

    Type: [[String]] -> AttrSet

    Arguments:
      lss: A list of lists, where each inner list contains two elements:
           - The first element is the name of the language server (String)
           - The second element is the language identifier (String)

    Returns:
      An attribute set where:
      - Keys are language server names
      - Values are objects with an `enable` property set to true if the corresponding language is in config.languages

    Example:
      enableLs [["rust-analyzer" "rust"] ["pyright" "python"]]
      # Given "config.languages == ["python"]"
      # -> { pyright: { enable = true; }; }
  */
  enableLs =
    lss:
    builtins.listToAttrs (
      builtins.map (ls: {
        name = builtins.elemAt ls 0;
        value = {
          enable = builtins.elem (builtins.elemAt ls 1) config.languages;
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
            [
              "html"
              "html"
            ]
            [
              "lua_ls"
              "lua"
            ]
            [
              "nixd"
              "nix"
            ]
            [
              "markdown_oxide"
              "markdown"
            ]
            [
              "pyright"
              "python"
            ]
            [
              "gopls"
              "go"
            ]
            [
              "yamlls"
              "yaml"
            ]
            [
              "elixirls"
              "elixir"
            ]
            [
              "volar"
              "vue"
            ]
            [
              "ts_ls"
              "typescript"
            ]
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
