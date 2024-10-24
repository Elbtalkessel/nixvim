{
  plugins = {
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      # Appends configuration after setting up all servers:
      # https://github.com/nix-community/nixvim/blob/main/plugins/lsp/default.nix
      postConfig = "
        # Not sure if it's correct or works at all, but fixes issue for me:
        # https://github.com/sqls-server/sqls/issues/153
        # Problem is, nixvim lsp configuration doesn't allow configure on_attach on
        # per-ls basis, only globally and all ls inherit specified configuration.
        require('lspconfig').sqls.setup{
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        }
      ";
      servers = {
        eslint = {
          enable = true;
        };
        html = {
          enable = true;
        };
        lua-ls = {
          enable = true;
        };
        nil-ls = {
          enable = true;
        };
        marksman = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        tsserver = {
          enable = false;
        };
        yamlls = {
          enable = true;
        };
        volar = {
          enable = true;
        };
        docker-compose-language-service = {
          enable = true;
        };
        dockerls = {
          enable = true;
        };
        htmx = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        nginx-language-server = {
          enable = true;
        };
        prismals = {
          enable = true;
        };
        sqls = {
          enable = true;
        };
        tailwindcss = {
          enable = true;
        };
        templ = {
          enable = true;
        };
        ccls = {
          enable = true;
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
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
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
  '';
}
